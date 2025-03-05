class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ authenticate ]

  def authenticate
    if user = User.authenticate_by(params.permit(:email_address, :password))
      render json: { token: ActionToken.encode(user.id) }, status: :ok
    else
      render json: { error: "Invalid email address or password" }, status: :unauthorized
    end
  end
end
