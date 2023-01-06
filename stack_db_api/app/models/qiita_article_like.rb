# == Schema Information
#
# Table name: qiita_article_likes
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  qiita_article_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_qiita_article_likes_on_qiita_article_id              (qiita_article_id)
#  index_qiita_article_likes_on_user_id                       (user_id)
#  index_qiita_article_likes_on_user_id_and_qiita_article_id  (user_id,qiita_article_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (qiita_article_id => qiita_articles.id)
#  fk_rails_...  (user_id => users.id)
#
class QiitaArticleLike < ApplicationRecord
  belongs_to :qiita_article
  belongs_to :user

  validates :qiita_article_id, uniqueness: { scope: :user_id }

end
