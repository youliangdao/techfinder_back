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
  validates :nickname,    presence: true, length: { maximum: 40 }
  validates :uid,         presence: true, uniqueness: true
  validates :description, length: { maximum: 160 } 

  def self.find_or_create_user(user_info)
    user = User.find_by(uid: user_info[:uid])
    return user if user

    User.create!(uid: user_info[:uid], nickname: "User_#{user_info[:uid]}")
  end  
end
