# == Schema Information
#
# Table name: qiita_articles
#
#  id         :bigint           not null, primary key
#  date       :string           not null
#  link       :string           not null
#  stock      :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :string
#
# Indexes
#
#  index_qiita_articles_on_item_id  (item_id) UNIQUE
#  index_qiita_articles_on_link     (link) UNIQUE
#
class QiitaArticle < ApplicationRecord
  has_many :qiita_category_maps, dependent: :destroy
  has_many :categories, through: :qiita_category_maps, dependent: :destroy

  validates :link,    presence: true, uniqueness: true
  validates :title,   presence: true
  validates :date,    presence: true
  validates :stock,   presence: true
  validates :item_id, presence: true, uniqueness: true
end
