class CommentSerializer
  include JSONAPI::Serializer
  attributes :body, :created_at

  belongs_to :user
end
