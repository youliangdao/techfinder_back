# == Schema Information
#
# Table name: qiita_category_maps
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :bigint           not null
#  qiita_article_id :bigint           not null
#
# Indexes
#
#  index_qiita_category_maps_on_category_id       (category_id)
#  index_qiita_category_maps_on_qiita_article_id  (qiita_article_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (qiita_article_id => qiita_articles.id)
#
class QiitaCategoryMap < ApplicationRecord
  belongs_to :qiita_article
  belongs_to :category
end
