class BookIncome < ApplicationService
  attr_reader :book, :start_at, :end_at

  def initialize(book:, start_at:, end_at:)
    @book = book
    @start_at = start_at
    @end_at = end_at
  end

  def call
    return failure("Invalid date range") if invalid_date_range?

    transactions = Transaction.where(book: book, borrowed_at: start_at..end_at)
    income = transactions.sum(&:fee_charged)
    success(income)
  end

  private

  def invalid_date_range?
    begin
      parsed_start = Date.parse(start_at)
      parsed_end = Date.parse(end_at)
    rescue Date::Error
      return true
    end

    parsed_start > parsed_end
  end
end
