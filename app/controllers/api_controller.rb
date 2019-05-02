class ApiController < ActionController::API
  include Pundit
  attr_reader :current_user
  before_action :authenticate_request
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include ActionController::HttpAuthentication::Token::ControllerMethods

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

  def authenticate_request
    @current_user = user
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def user_not_authorized
    render json: { error: 'You need permission' }, status: 403
  end
end