class Api::V1::Genre::ArticlesController < Api::V1::BaseController
  skip_before_action :authenticate
  before_action :find_articles

  def index
    json_string = ArticleSerializer.new(@articles, options).serializable_hash.to_json
    render json: json_string
  end

  private 

  def find_articles
    @articles = Article.genre(params[:genre_name])
  end

  def options
    options = {}
    options[:include] = [:categories]
    options
  end  
end