class UserSerializer
  include JSONAPI::Serializer
  attributes :nickname, :description, :avatar_key
end
