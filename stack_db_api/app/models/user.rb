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
  has_many :bookmark_articles, through: :bookmarks, source: :article
  has_many :likes, dependent: :destroy
  has_many :like_articles, through: :likes, source: :article
  has_many :comments, dependent: :destroy
  has_many :comment_articles, through: :comments, source: :article
  
  validates :nickname,    presence: true, length: { maximum: 40 }
  validates :uid,         presence: true, uniqueness: true
  validates :description, length: { maximum: 160 } 

  def self.find_or_create_user(user_info)
    user = User.find_by(uid: user_info[:uid])
    return user if user

    User.create!(uid: user_info[:uid], nickname: "User_#{user_info[:uid]}")
  end

  def own?(object)
    id == object.user_id
  end

  def bookmark(article)
    bookmark_articles << article
  end

  def unbookmark(article)
    bookmark_articles.destroy(article)
  end

  def like(article)
    like_articles << article
  end

  def unlike(article)
    like_articles.destroy(article)
  end

end
