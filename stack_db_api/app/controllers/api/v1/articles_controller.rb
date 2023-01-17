class Api::V1::ArticlesController < Api::V1::BaseController
  skip_before_action :authenticate, only: %w[index rising]

  def index
    if params[:tab] == "popular"
      articles = Article.popular
    else
      articles = Article.all.recent
    end
    json_string = ArticleSerializer.new(articles, options).serializable_hash.to_json
    render json: json_string
  end

  def rising
    qiita_articles = Article.where(media_name: "qiita.com").where("stock > ?", 100).recent.limit(5)
    zenn_articles = Article.where(media_name: "zenn.dev").where("stock > ?", 100).recent.limit(5)
    articles = qiita_articles | zenn_articles
    
    json_string = ArticleSerializer.new(articles, options).serializable_hash.to_json
    render json: json_string
  end

  def bookmarks
    json_string = ArticleSerializer.new(current_user.bookmark_articles, options).serializable_hash.to_json
    render json: json_string
  end

  def likes
    json_string = ArticleSerializer.new(current_user.like_articles, options).serializable_hash.to_json
    render json: json_string
  end

  def comments
    json_string = ArticleSerializer.new(current_user.comment_articles, options).serializable_hash.to_json
    render json: json_string
  end

  def bookmark_comments
    bookmark_or_comment_articles = current_user.bookmark_articles | current_user.comment_articles
    bookmark_comment_articles = Article.where(id: bookmark_or_comment_articles.map(&:id))
    json_string = ArticleSerializer.new(bookmark_comment_articles, options).serializable_hash.to_json
    render json: json_string
  end

  private

  def options
    options = {}
    options[:include] = [:categories]
    options
  end
end