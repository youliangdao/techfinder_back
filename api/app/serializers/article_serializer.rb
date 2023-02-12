# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  date        :string           not null
#  image       :string           not null
#  link        :string           not null
#  media_image :string           not null
#  media_name  :string           not null
#  stock       :integer          not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  item_id     :string
#
# Indexes
#
#  index_articles_on_link  (link) UNIQUE
#
class ArticleSerializer
  include JSONAPI::Serializer
  attributes :date, :link, :stock, :title, :item_id, :image, :media_name, :media_image

  has_many :categories
end
