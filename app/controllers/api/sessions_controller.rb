class Api::SessionsController < ApiController
  skip_before_action :require_login, only: :create
 
  def create
    user = User.find_by_email(params[:email])
    if user && user.valid_password?(params[:password])
      
      render json: { token: user.token }
    else
      render_unauthorized('Incorrect email or password')
    end
  end
 
  def destroy
    current_user.invalidate_token
    head :ok
  end
 end