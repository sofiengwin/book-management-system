require 'rails_helper'

RSpec.describe BookIncome do
  let(:book) { create(:book) }
  let(:user) { create(:user) }
  let(:start_at) { 2.day.ago.strftime('%Y-%m-%d') }
  let(:end_at) { Time.now.strftime('%Y-%m-%d') }

  it 'calculates income' do
    create(:transaction, book: book, user: user, fee_charged: 5.0, borrowed_at: 1.days.ago)
    create(:transaction, book: book, user: user, fee_charged: 10.0, borrowed_at: 1.days.ago)
    result = BookIncome.new(book: book, start_at: start_at, end_at: end_at).call

    expect(result.success?).to eq true
    expect(result.value).to eq 15.0
  end

  it 'does not calculate income for different book' do
    create(:transaction, fee_charged: 5.0, borrowed_at: 2.days.ago, book: create(:book), user: user)
    result = BookIncome.new(book: book, start_at: start_at, end_at: end_at).call
    expect(result.success?).to eq true
    expect(result.value).to eq 0.0
  end
end
