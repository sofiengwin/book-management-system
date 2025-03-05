class Api::V1::TransactionsController < ApplicationController
  before_action :set_book
  before_action :set_user

  def borrow
    result = BorrowBook.call(user: @user, book: @book)

    if result.success?
      render json: { message: "Book borrowed successfully", transaction: result.value }, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  def return
    result = ReturnBook.call(user: @user, book: @book)

    if result.success?
      render json: { message: "Book returned successfully", transaction: result.value }, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
