require 'rails_helper'

RSpec.describe ReturnBook do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  context 'when user has a borrowed book' do
    it 'returns a book' do
      create(:transaction, user: user, book: book)
      result = ReturnBook.new(user: user, book: book).call
      expect(result.success?).to eq true
      expect(result.value.book_id).to eq book.id
      expect(result.value.user_id).to eq user.id
      expect(result.value.borrowed_at).to be_present
      expect(result.value.returned_at).to be_present

      expect(user.books.length).to eq 1
    end
  end

  context 'when user does not have a borrowed book' do
    it 'does not return a book' do
      result = ReturnBook.new(user: user, book: book).call
      expect(result.success?).to eq false
      expect(result.error).to eq 'No active borrowed book found'
    end
  end
end
