class Api::V1::ImagesController < Api::V1::BaseController
  skip_before_action :authenticate, only: %w[avatar]
  def create
    s3_direct_post
    render json: { status: :ok, url: @resource.url, fields: @resource.fields }
  end

  def show
    url = file_url(current_user.avatar_key)
    render json: {status: :ok, url: url}
  end

  def avatar
    user = User.find(params[:user_id])
    url = file_url(user.avatar_key)
    render json: {status: :ok, url: url}   
  end

  private

  def s3_direct_post
    @resource = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read', content_length_range: 1..(10.megabytes))
  end

  def file_url(avatar_key)
    Aws::S3::Object.new(ENV['S3_BUCKET_NAME'], avatar_key).public_url    
  end

end