# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  avatar_key       :string
#  description      :text
#  github_username  :string
#  nickname         :string(40)       not null
#  twitter_username :string
#  uid              :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_uid  (uid) UNIQUE
#
class User < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_qiita_articles, through: :bookmarks, source: :qiita_article
  has_many :qiita_article_likes, dependent: :destroy
  has_many :like_qiita_articles, through: :qiita_article_likes, source: :qiita_article
  
  validates :nickname,    presence: true, length: { maximum: 40 }
  validates :uid,         presence: true, uniqueness: true
  validates :description, length: { maximum: 160 } 

  def self.find_or_create_user(user_info)
    user = User.find_by(uid: user_info[:uid])
    return user if user

    User.create!(uid: user_info[:uid], nickname: "User_#{user_info[:uid]}")
  end

  def bookmark(qiita_article)
    bookmark_qiita_articles << qiita_article
  end

  def unbookmark(qiita_article)
    bookmark_qiita_articles.destroy(qiita_article)
  end

  def like(qiita_article)
    like_qiita_articles << qiita_article
  end

  def unlike(qiita_article)
    like_qiita_articles.destroy(qiita_article)
  end

end
