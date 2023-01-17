class Api::V1::BookmarksController < Api::V1::BaseController
  skip_before_action :authenticate, only: %w[index]

  def index
    article_bookmarks_count = Article.find(params[:article_id]).bookmarks.length
    render json: {status: :ok, count: article_bookmarks_count}    
  end

  def create
    article = Article.find(params[:article_id])
    current_user.bookmark(article)
    json_string = ArticleSerializer.new(article, options).serializable_hash.to_json
    render json: json_string
  end

  def destroy
    article = Article.find(params[:id])
    current_user.unbookmark(article)
    render json: { status: :ok }
  end

  private

  def options
    options = {}
    options[:include] = [:categories]
    options
  end  
end