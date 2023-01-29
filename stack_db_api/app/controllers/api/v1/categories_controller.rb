class Api::V1::CategoriesController < Api::V1::BaseController
  skip_before_action :authenticate

  def index
    categories = Category.joins(:category_maps).group(:id).order('count(article_id) desc')
    json_string = CategorySerializer.new(categories).serializable_hash.to_json
    render json: json_string
  end

  def show
    category = Category.find_by(path: params[:category_name])
    json_string = CategorySerializer.new(category).serializable_hash.to_json
    render json: json_string
  end

  def popular
    categories = Category.joins(:category_maps).group(:id).order('count(article_id) desc').limit(15)

    json_string = CategorySerializer.new(categories).serializable_hash.to_json
    render json: json_string
  end
end