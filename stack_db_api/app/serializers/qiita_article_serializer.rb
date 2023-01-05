# == Schema Information
#
# Table name: qiita_articles
#
#  id         :bigint           not null, primary key
#  date       :string           not null
#  image      :string           not null
#  link       :string           not null
#  stock      :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :string           not null
#
# Indexes
#
#  index_qiita_articles_on_item_id  (item_id) UNIQUE
#  index_qiita_articles_on_link     (link) UNIQUE
#
class QiitaArticleSerializer
  include JSONAPI::Serializer
  attributes :date, :link, :stock, :title, :item_id, :image

  has_many :categories
end
