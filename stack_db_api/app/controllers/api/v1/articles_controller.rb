class Api::V1::ArticlesController < Api::V1::BaseController
  skip_before_action :authenticate

  def index
    if params[:tab] == "popular"
      qiita_articles = QiitaArticle.popular
    else
      qiita_articles = QiitaArticle.all
    end
    json_string = QiitaArticleSerializer.new(qiita_articles, options).serializable_hash.to_json
    render json: json_string
  end

  def rising
    qiita_articles = QiitaArticle.where("stock > ?", 100).recent.limit(10)
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
end