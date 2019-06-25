class Api::SessionsController < ApiController
  skip_before_action :require_login, only: :create
 
  def create
    user = User.find_by_email(params[:email])
    if user && user.valid_password?(params[:password])
      user.generate_token
      token = user.token
      cookies.signed[:auth_token] = { value: token, httponly: true }
      render json: { token: token }
    else
      render_unauthorized('Incorrect email or password')
    end
  end
 
  def destroy
    current_user.invalidate_token
    head :ok
  end
 end