class CategorySerializer
  include JSONAPI::Serializer
  attributes :image, :name, :path
end
