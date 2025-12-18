class ApplicationController < ActionController::API
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user

  private
  def user_not_authorized
    render json: { error: "Forbidden" }, status: :forbidden
  end

  def authenticate_user
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    return render json: { error: "Missing token" }, status: :unauthorized unless token

    begin
      decoded = Auth::JwtService.decode(token)
      @current_user = User.find_by(id: decoded[:user_id])
    rescue JWT::ExpiredSignature
      render json: { error: "Expired token" }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
