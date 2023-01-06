class Api::V1::QiitaArticleLikesController < Api::V1::BaseController
  def create
    qiita_article = QiitaArticle.find(params[:qiita_article_id])
    current_user.like(qiita_article)
    render json: {status: :ok, message: "like successfuly created!"}
  end

  def destroy
    qiita_article = QiitaArticle.find(params[:id])
    current_user.unlike(qiita_article)
    render json: { status: :ok }
  end
end