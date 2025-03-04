class Api::V1::TransactionController < ApplicationController
  def borrow
    user = User.find(params[:user_id])
    book = Book.find(params[:book_id])

    if book.available_copies > 0 && user.balance >= 5
      transaction = Transaction.create!(user: user, book: book, borrowed_at: Time.now, status: :borrowed, fee_charged: 5)
      book.update(available_copies: book.available_copies - 1)
      render json: { message: "Book borrowed successfully" }, status: :ok
    else
      render json: { error: "Cannot borrow book" }, status: :unprocessable_entity
    end
  end

  def return
    transaction = Transaction.find_by(user_id: params[:user_id], book_id: params[:book_id], status: :borrowed)
    if transaction
      transaction.update(returned_at: Time.now, status: :returned)
      transaction.book.update(available_copies: transaction.book.available_copies + 1)
      render json: { message: "Book returned successfully" }, status: :ok
    else
      render json: { error: "No active loan found" }, status: :not_found
    end
  end
end
