class Auth::RegistrationsController < ApplicationController
  def create
    user = User.create!(user_params)
    token = Auth::JwtService.encode(user_id: user.id)

    render json: { token: token }, status: :created
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
