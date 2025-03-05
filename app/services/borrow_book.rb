class BorrowBook < ApplicationService
  attr_reader :user, :book

  def initialize(user:, book:)
    @user = user
    @book = book
  end

  def call
    return failure("Insufficient balance to borrow") unless @user.can_borrow_book?(fee_charged: Book::BORROW_FEE)

    borrow_transaction = ActiveRecord::Base.transaction do
      user.update!(balance: user.balance - Book::BORROW_FEE)
      Transaction.create(user: user, book: book, borrowed_at: Time.now, fee_charged: Book::BORROW_FEE)
    end
    success(borrow_transaction)
  end
end
