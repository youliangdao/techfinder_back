# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  image      :string           not null
#  name       :string           not null
#  path       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#  index_categories_on_path  (path) UNIQUE
#
class Category < ApplicationRecord
  has_many :qiita_category_maps, dependent: :destroy
  has_many :qiita_articles, through: :qiita_category_maps, dependent: :destroy

  validates :name,  presence: true, uniqueness: true
  validates :image, presence: true
end
