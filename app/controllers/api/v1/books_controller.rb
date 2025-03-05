class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: %i[ income ]

  def index
    render json: { books: Book.all }, status: :ok
  end
  def income
    result = BookIncome.call(book: @book, start_at: params[:start_at], end_at: params[:end_at])

    if result.success?
      render json: { income: result.value }, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
