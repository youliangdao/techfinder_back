class Api::V1::ImagesController < Api::V1::BaseController
  def create
    s3_direct_post
    render json: { status: :ok, url: @resource.url, fields: @resource.fields }
  end

  def show
    url = Aws::S3::Object.new(ENV['S3_BUCKET_NAME'], current_user.avatar_key).public_url
    render json: {status: :ok, url: url}
  end

  private

  def s3_direct_post
    @resource = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read', content_length_range: 1..(10.megabytes))
  end

end