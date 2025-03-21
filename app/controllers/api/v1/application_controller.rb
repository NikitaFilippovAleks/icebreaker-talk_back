class Api::V1::ApplicationController < ApplicationController
  before_action :authenticate_user

  def authenticate_user
    token = header_token if header_token.present?
    return render json: { error: "Missing token" }, status: :unauthorized unless token

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::ExpiredSignature
      render json: { error: "Expired token" }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end

  private

  def header_token
    auth_header = request.headers['Authorization']

    if auth_header
      auth_header.split(' ').last
    end
  end
end
