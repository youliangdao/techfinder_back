require 'link_thumbnailer'
class QiitaArticleSerializer
  include JSONAPI::Serializer
  attributes :date, :link, :stock, :title, :item_id
  attributes :image do |object|
    result = LinkThumbnailer.generate("#{object.link}")
    result.images.first.src.to_s
  end

  has_many :categories
end
