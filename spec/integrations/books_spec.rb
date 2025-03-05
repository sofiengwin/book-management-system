require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe "GET /api/v1/books/:id/income" do
    context "when BookIncome call is successful" do
      it "returns income" do
      create(:transaction, book: book, user: user, fee_charged: 100.0, borrowed_at: 15.days.ago)
        get(
          income_api_v1_book_path(book),
          params: { start_at: 30.days.ago, end_at: Time.now },
          headers: { 'Authorization': "#{token_for_user(user)}" }
        )

        expect(response).to have_http_status(:ok)
        expect(json_response[:income]).to eq('100.0')
      end
    end

    context "when BookIncome call is fails" do
      it "returns income" do
      create(:transaction, book: book, user: user, fee_charged: 100.0, borrowed_at: 15.days.ago)
        get(
          income_api_v1_book_path(book),
          params: { start_at: 30.days.ago, end_at: 'invalid' },
          headers: { 'Authorization': "#{token_for_user(user)}" }
        )

        expect(response).to have_http_status(:unprocessable_entity)
        pp json_response
        expect(json_response[:error]).to eq("Invalid date range")
      end
    end
  end
end
