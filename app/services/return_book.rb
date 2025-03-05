class ReturnBook < ApplicationService
  attr_reader :user, :book

  def initialize(user:, book:)
    @user = user
    @book = book
  end

  def call
    transaction = Transaction.where(returned_at: nil).find_by(user: user, book: book)
    return failure("No active borrowed book found") unless transaction

    transaction.update!(returned_at: Time.now)
    success(transaction)
  end
end
