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
#  uid              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class User < ApplicationRecord
  validates :nickname,    presence: true, length: { maximum: 40 }
  validates :uid,         uniqueness: true
  validates :avatar_key,  uniqueness: true
  validates :description, length: { maximum: 160 } 
end
