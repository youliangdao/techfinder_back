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
class Article < ApplicationRecord
  has_many :category_maps, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :categories, through: :category_maps, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  scope :popular, -> { where("stock > ?", 100).order(stock: :desc) }
  scope :recent, -> { order(date: :desc) }

  validates :link,    presence: true, uniqueness: true
  validates :title,   presence: true
  validates :date,    presence: true
  validates :stock,   presence: true
end
