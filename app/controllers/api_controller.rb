class ApiController < ActionController::API

  include Pundit
  
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  before_action :require_login

  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  def current_user
    @current_user ||= authenticate_token
  end

  private

  def render_unauthorized(message)
    errors = { errors: { message: message } }
    render json: errors, status: :unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end

  def user_not_authorized
    render_unauthorized("Role not defined")
  end
end