class Api::V1::AuthenticationsController < Api::V1::BaseController
  def create
    render json: { message: "User successfully logged in!" } if current_user
  end  
end