class Api::V1::CommentsController < Api::V1::BaseController
  skip_before_action :authenticate, only: %w[index]

  def index
    qiita_article = QiitaArticle.find(params[:article_id])
    comments = qiita_article.comments
    json_string = CommentSerializer.new(comments, options).serializable_hash.to_json
    render json: json_string
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      json_string = CommentSerializer.new(@comment, options).serializable_hash.to_json
      render json: json_string
    else
      render_400(nil, @comment.errors.full_messages)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    render json: {status: :ok, message: "successfully comment deleted!"}
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(update_comment_params)
      json_string = CommentSerializer.new(@comment, options).serializable_hash.to_json
      render json: json_string      
    else
      render_400(nil, @comment.errors.full_messages)
    end    
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(qiita_article_id: params[:article_id])
  end

  def update_comment_params
    params.require(:comment).permit(:body)    
  end

  def options
    options = {}
    options[:include] = [:user]
    options
  end

end