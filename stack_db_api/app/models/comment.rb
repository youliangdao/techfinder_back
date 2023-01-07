# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  qiita_article_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_qiita_article_id  (qiita_article_id)
#  index_comments_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (qiita_article_id => qiita_articles.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :qiita_article
  belongs_to :user

  validates :body, presence: true, length: { maximum: 2000 }
end
