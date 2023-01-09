class Api::V1::BookmarksController < Api::V1::BaseController
  skip_before_action :authenticate, only: %w[index]

  def index
    article_bookmarks_count = Article.find(params[:article_id]).bookmarks.length
    render json: {status: :ok, count: article_bookmarks_count}    
  end

  def create
    article = Article.find(params[:article_id])
    current_user.bookmark(article)
    render json: {status: :ok, message: "Bookmark successfuly created!"}
  end

  def destroy
    article = Article.find(params[:id])
    current_user.unbookmark(article)
    render json: { status: :ok }
  end
end