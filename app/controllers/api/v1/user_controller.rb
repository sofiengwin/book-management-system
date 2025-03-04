class Api::V1::UserController < ApplicationController
  def create
    user = User.create(user_params)
    render json: { user_id: user.id, balance: user.balance }, status: :created
  end

  def account
    user = User.find(params[:id])
    render json: { balance: user.balance, borrowed_books: user.books }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :balance)
  end
end
