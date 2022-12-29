# このモジュールは、Firebase JWT ID トークンを以下のルールに従って検証するためのものです。
# https://firebase.google.com/docs/auth/admin/verify-id-tokens#verify_id_tokens_using_a_third-party_jwt_library
#
# トークン検証は以下の3つのステップを経ることで実現する
#  1. JWTをデコード
#  2. トークン情報のフォーマットチェック
#  3. トークンが正しい秘密鍵から作られていることを確認
# 
# 注意：上記のステップ3を行うためには公開鍵を取得する必要があり、
#      そのためにはトークンを1度デコードする必要がある
#  1. 1回目は署名検証に必要な公開鍵識別子（kid）の取得のため、検証なしでデコードする
#     これにより自分の署名検証に必要な公開鍵を特定し、Googleから取得する
#  2. 2回目は実際の検証を行うためにデコードする

require 'jwt'
require 'net/http'

module FirebaseAuth
  ALGORITHM = "RS256".freeze
  
  # "iss"は "https://securetoken.google.com/<FIREBASE_PROJECT_ID>"
  ISSUER_PREFIX = "https://securetoken.google.com/".freeze
  FIREBASE_PROJECT_ID = ENV["FIREBASE_PROJECT_ID"]
  
  # 下記のURLからGoogle公開鍵証明書リストを取得する
  CERT_URI =
    "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com".freeze
  
  # 検証用のラッパーメソッドは以下のようなロジックで動かす:
  #   1. ヘッダーを取得するために、検証を行わずにトークンをデコード
  #   2. ヘッダから公開鍵の識別子を使用して、公開鍵を取得
  #   3. トークンのフォーマットチェック＋署名検証
  #   4. 全ての検証が成功したら、ユーザー識別子subを返却
  #   5. それ以外の場合は、エラーを返す
  #
  # デコードして得られるPayloadの中身は以下のようになる
  # Payload =>
  # {
  #   "name": "<username>",
  #   "picture": "<user_profile_picture>",
  #   "iss": "https://securetoken.google.com/<FIREBASE_PROJECT_ID>",
  #   "aud": "<firebase_project_id>",
  #   "auth_time": ユーザーが認証を行った日時のUNIXタイム,
  #   "user_id": "<user_id>(same as sub)",
  #   "sub": "<subject>",
  #   "iat": IDトークンの発行日時のUNIXタイム,
  #   "exp": IDトークンの有効期限のUNIXタイム,
  #   "email": "<user email>",
  #   "email_verified": true,
  #   "firebase": {
  #     "identities": {
  #       "google.com": [
  #         "<google_user_id>"
  #       ],
  #       "email": [
  #         "<user_gmail>"
  #       ]
  #     },
  #     "sign_in_provider": "google.com"
  #   }
  # }  

  def verify_id_token(id_token)
    payload, header = decoded_unverified(id_token)
    public_key = get_public_key(header)

    errors = verify(id_token, public_key)
    if errors.empty?
      return(
        {
          uid: payload["user_id"],
          nickname: payload["name"],
          avatar: payload["picture"],
        }
      )
    end

    return { errors: errors.join(" / ") }    
  end

  private

  # 検証を行わずにトークンをデコード
  # 今回のJWT.decodeの書式
  # JWT.decode(token, key=nil, verify=false, option={ algorithm: ALGORITHM })
  # verify部分をfalseにすることで、検証をスキップしてデコードを行う（参照：https://github.com/jwt/ruby-jwt/issues/216#issuecomment-319010415）
  # これによりヘッダ部分から公開鍵識別子を取得し、署名検証に必要な公開鍵を取得する
  def decoded_unverified(token)
    decode_token(
      token: token,
      key: nil,
      verify: false,
      options: {
        algorithm: ALGORITHM
      }
    )
  end

  # Returns:
  #    Array: decoded data of ID token =>
  #    [
  #      {
  #        aud: "<firebase_project_id>",
  #        auth_time: ...,
  #        user_id: "<user_id>(same as sub)",
  #        sub: "<subject>",
  #        ...略
  #      }, # payload部分
  #      { alg: "RS256", kid: "XXXXXXX", typ: "JWT" } # header部分
  #    ]
  def decode_token(token:, key:, verify:, options:)
    JWT.decode(token, key, verify, options)
  end

  # ヘッダの中のkidを用いて公開鍵を取得する
  # Googleの公開鍵はX.509にて作成されているのでそれに従って証明書を作成し、公開鍵を取得する。
  def get_public_key(header)
    certificate = find_certificate(header["kid"])
    _public_key = OpenSSL::X509::Certificate.new(certificate).public_key
  rescue OpenSSL::X509::CertificateError => e
    raise "Invalid certificate. #{e.message}"
  
  end

  # 公開鍵が存在する証明書を探すためのkeyがkid
  # Googleの公開鍵証明書リストは以下のような書式になっている:
  # {
  #   "key_1": "CERTIFICATE_1",
  #   "key_2": "CERTIFICATE_2"
  # }  
  def find_certificate(kid)
    certificates = fetch_certificates
    unless certificates.key?(kid)
      raise "Invalid 'kid', do not correspond to one of valid public keys."      
    end

    _valid_certificate = certificates[kid]
  end

  # CERT_URLから証明書リストを取得する
  def fetch_certificates
    uri = URI.parse(CERT_URI)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    req = Net::HTTP::Get.new(uri.path)
    res = https.request(req)
    unless res.code == "200"
      raise "Error: can't obtain valid public key certificates from Google."
    end

    _certificates = JSON.parse(res.body)
  end

  # 与えられたJWTトークンのフォーマットチェックと検証を行う
  # トークンになにか問題があった場合はエラーを返す
  def verify(token, key)
    errors = []

    begin
      decoded_token = 
        decode_token(
          token: token,
          key: key,
          verify: true,
          options: decode_options,
        )
    rescue JWT::ExpiredSignature
      errors << "Firebase ID token has expired. Get a fresh token from your app and try again."
    rescue JWT::InvalidIatError
      errors << "Invalid ID token. 'Issued-at time' (iat) must be in the past."
    rescue JWT::InvalidIssuerError
      errors << "Invalid ID token. 'Issuer' (iss) Must be 'https://securetoken.google.com/<firebase_project_id>'."
    rescue JWT::InvalidAudError
      errors << "Invalid ID token. 'Audience' (aud) must be your Firebase project ID."
    rescue JWT::VerificationError => e
      errors << "Firebase ID token has invalid signature. #{e.message}"
    rescue JWT::DecodeError => e
      errors << "Invalid ID token. #{e.message}"
    end


    sub = decoded_token[0]["sub"]
    alg = decoded_token[1]["alg"]


    # subject ("sub") と algorithm ("alg")を追加検証する（JWT.decodeで検証できないため）
    errors << 'Firebase ID token has no "sub" (subject) claim.' unless sub.is_a?(String)
    errors << 'Firebase ID token has an empty string "sub" (subject) claim.'  if sub.empty?
    errors << 'Firebase ID token has "sub" (subject) claim longer than 128 characters.' if sub.size > 128
    errors << "Invalid ID token. 'alg' must be '#{ALGORITHM}', but got #{alg}." unless alg == ALGORITHM

    return errors
  end

  def decode_options
    {
      iss: ISSUER_PREFIX + FIREBASE_PROJECT_ID,
      aud: FIREBASE_PROJECT_ID,
      algorithm: ALGORITHM,
      verify_iat: true,
      verify_iss: true,
      verify_aud: true
    }
  end
end
