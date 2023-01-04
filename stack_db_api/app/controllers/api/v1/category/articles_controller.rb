class Api::V1::Category::ArticlesController < Api::V1::BaseController
  skip_before_action :authenticate
  before_action :find_category

  def index
    if params[:tab] == "popular"
      qiita_articles = @category.qiita_articles.popular
    else
      qiita_articles = @category.qiita_articles
    end
    json_string = QiitaArticleSerializer.new(qiita_articles, options).serializable_hash.to_json
    render json: json_string
  end

  private
  
  def options
    options = {}
    options[:meta] = { media: { name: "qiita.com", image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png" } }
    options[:include] = [:categories]
    options
  end

  def find_category
    @category = Category.find_by(path: params[:category_name])
  end
end