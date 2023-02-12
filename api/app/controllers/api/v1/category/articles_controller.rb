class Api::V1::Category::ArticlesController < Api::V1::BaseController
  skip_before_action :authenticate
  before_action :find_category

  def index
    if params[:tab] == "popular"
      articles = @category.articles.popular
    else
      articles = @category.articles.recent
    end
    json_string = ArticleSerializer.new(articles, options).serializable_hash.to_json
    render json: json_string
  end

  private
  
  def options
    options = {}
    options[:include] = [:categories]
    options
  end

  def find_category
    @category = Category.find_by(path: params[:category_name])
  end
end