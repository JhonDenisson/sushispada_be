class Auth::SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    normalized_credentials = {
      username: credentials_params[:username].to_s.strip.downcase,
      password: credentials_params[:password].to_s
    }

    if normalized_credentials.values.any?(&:blank?)
      return render json: { error: "Email and password are required" }, status: :bad_request
    end

    user = User.find_by(email: normalized_credentials[:username])

    return render json: { error: "User not found" }, status: :not_found unless user

    unless user.authenticate(normalized_credentials[:password])
      return render json: { error: "Invalid credentials" }, status: :unauthorized
    end

    token = Auth::JwtService.encode(user_id: user.id)

    cookies[:access_token] = {
      value: token,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax,
      expires: 24.hours.from_now
    }

    render json: { expires_in: 24.hours.seconds.to_i }, status: :created
  end

  private

  def credentials_params
    params.permit(:username, :password)
  end
end
