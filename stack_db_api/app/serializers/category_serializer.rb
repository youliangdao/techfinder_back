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
class CategorySerializer
  include JSONAPI::Serializer
  attributes :image, :name, :path
end
