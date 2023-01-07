class Api::V1::BookmarksController < Api::V1::BaseController
  skip_before_action :authenticate, only: %w[index]

  def index
    article_bookmarks_count = QiitaArticle.find(params[:article_id]).bookmarks.length
    render json: {status: :ok, count: article_bookmarks_count}    
  end

  def create
    qiita_article = QiitaArticle.find(params[:qiita_article_id])
    current_user.bookmark(qiita_article)
    render json: {status: :ok, message: "Bookmark successfuly created!"}
  end

  def destroy
    qiita_article = QiitaArticle.find(params[:id])
    current_user.unbookmark(qiita_article)
    render json: { status: :ok }
  end
end