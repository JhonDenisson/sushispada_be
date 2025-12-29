class Auth::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    user = User.find_by(email: user_params[:email])

    return render json: { error: "Email and password are required" }, status: :bad_request if user_params[:email].blank? || user_params[:password].blank?
    return render json: { error: "Email already registered" }, status: :not_found if user.present?

    user = User.create!(user_params)
    token = Auth::JWTService.encode(user_id: user.id)


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

  def user_params
    params.permit(:name, :email, :password)
  end
end
