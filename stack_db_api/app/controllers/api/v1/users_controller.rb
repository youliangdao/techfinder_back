class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate

  def show
    user = User.find(params[:id])
    json_string = UserSerializer.new(user).serializable_hash.to_json
    render json: json_string
  end

  def likes
    user = User.find(params[:user_id])
    json_string = ArticleSerializer.new(user.like_articles, options).serializable_hash.to_json
    render json: json_string
  end

  def comments
    user = User.find(params[:user_id])
    json_string = ArticleSerializer.new(user.comment_articles, options).serializable_hash.to_json
    render json: json_string    
  end

  private
    
  def options
    options = {}
    options[:include] = [:categories]
    options
  end
end