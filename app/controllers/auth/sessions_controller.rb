class Auth::SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    normalized_credentials = {
      email: credentials_params[:email].to_s.strip.downcase,
      password: credentials_params[:password].to_s
    }

    if normalized_credentials.values.any?(&:blank?)
      return render json: { error: 'Email and password are required' }, status: :bad_request
    end

    user = User.find_by(email: normalized_credentials[:email])

    return render json: { error: 'User not found' }, status: :not_found unless user

    unless user.authenticate(normalized_credentials[:password])
      return render json: { error: 'Invalid credentials' }, status: :unauthorized
    end

    token = Auth::JwtService.encode(user_id: user.id)
    render json: { token: token }, status: :created
  end

  private

  def credentials_params
    params.permit(:email, :password)
  end
end
