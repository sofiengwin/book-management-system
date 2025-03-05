require 'rails_helper'

RSpec.describe BorrowBook do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  context 'when user has enough balance' do
    it 'borrows a book' do
      result = BorrowBook.new(user: user, book: book).call
      expect(result.success?).to eq true
      expect(result.value.book_id).to eq book.id
      expect(result.value.user_id).to eq user.id
      expect(result.value.fee_charged).to eq 5.0
      expect(result.value.borrowed_at).to be_present
      expect(result.value.returned_at).to be_falsey

      user.reload
      expect(user.balance).to eq 95.0
      expect(user.books.length).to eq 1
      expect(user.books[0].title).to eq 'Oliver Twist'
      expect(user.books[0].author).to eq 'Charles Dickens'
      expect(user.books[0].genre).to eq 'Fiction'
    end
  end

  context 'when user does not have enough balance' do
    it 'does not borrow a book' do
      user.update(balance: 0)
      result = BorrowBook.new(user: user, book: book).call
      expect(result.success?).to eq false
      expect(result.error).to eq 'Insufficient balance to borrow'
      user.reload
      expect(user.balance).to eq 0
      expect(user.books.length).to eq 0
    end
  end
end
