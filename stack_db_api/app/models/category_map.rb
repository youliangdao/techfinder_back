# == Schema Information
#
# Table name: category_maps
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  article_id  :bigint           not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_category_maps_on_article_id   (article_id)
#  index_category_maps_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (category_id => categories.id)
#
class CategoryMap < ApplicationRecord
  belongs_to :article
  belongs_to :category
end
