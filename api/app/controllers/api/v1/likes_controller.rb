class Api::V1::LikesController < Api::V1::BaseController
  skip_before_action :authenticate, only: %w[index]

  def index
    article_likes_count = Article.find(params[:article_id]).likes.length
    render json: {status: :ok, count: article_likes_count}
  end

  def create
    article = Article.find(params[:article_id])
    current_user.like(article)
    render json: {status: :ok, message: "like successfuly created!"}
  end

  def destroy
    article = Article.find(params[:id])
    current_user.unlike(article)
    render json: { status: :ok }
  end
end