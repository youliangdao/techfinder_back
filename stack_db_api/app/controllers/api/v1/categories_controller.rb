class Api::V1::CategoriesController < Api::V1::BaseController
  skip_before_action :authenticate

  def index
    categories = Category.all
    json_string = CategorySerializer.new(categories).serializable_hash.to_json
    render json: json_string
  end

  def show
    category = Category.find_by(path: params[:category_name])
    json_string = CategorySerializer.new(category).serializable_hash.to_json
    render json: json_string
  end

  def popular
    categories = Category.where(name: "Rails")
      .or(Category.where(name: "JavaScript"))
      .or(Category.where(name: "AWS"))
      .or(Category.where(name: "Ruby"))
      .or(Category.where(name: "React"))
      .or(Category.where(name: "Vue.js"))
      .or(Category.where(name: "Firebase"))
      .or(Category.where(name: "Laravel"))
      .or(Category.where(name: "ポエム"))
      .or(Category.where(name: "Nuxt.js"))
      .or(Category.where(name: "Python"))
      .or(Category.where(name: "TypeScript"))
      .or(Category.where(name: "デザイン（Design）"))
      .or(Category.where(name: "PHP"))
      .or(Category.where(name: "GitHub"))

    json_string = CategorySerializer.new(categories).serializable_hash.to_json
    render json: json_string
  end
end