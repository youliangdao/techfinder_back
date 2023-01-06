class Api::V1::BookmarksController < Api::V1::BaseController
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