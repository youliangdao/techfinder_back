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
class UserSerializer
  include JSONAPI::Serializer
  attributes :nickname, :description, :avatar_key
end
