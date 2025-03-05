require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe "POST /transactions/borrow" do
    context "with valid parameters" do
      it "creates a transaction" do
        post(
          borrow_api_v1_transactions_path,
          params: { user_id: user.id, book_id: book.id },
          headers: { 'Authorization': "#{token_for_user(user)}" }
        )

        expect(response).to have_http_status(:ok)
        expect(json_response[:transaction][:user_id]).to eq user.id
        expect(json_response[:transaction][:book_id]).to eq book.id
        expect(json_response[:transaction][:borrowed_at]).to be_present
        expect(json_response[:transaction][:returned_at]).to be_falsey
      end
    end

    context "with invalid parameters" do
      it "does not create a transaction" do
        post(
          borrow_api_v1_transactions_path,
          params: { user_id: user.id, book_id: nil },
          headers: { 'Authorization': "#{token_for_user(user)}" }
        )

        expect(response).to have_http_status(:not_found)
        expect(json_response[:error]).to eq "Couldn't find Book without an ID"
      end
    end
  end

  describe "POST /transactions/return" do
    context "with valid parameters" do
      it "updates a transaction" do
        create(:transaction, user: user, book: book)
        post(
          return_api_v1_transactions_path,
          params: { user_id: user.id, book_id: book.id },
          headers: { 'Authorization': "#{token_for_user(user)}" }
        )
        expect(response).to have_http_status(:ok)
        expect(json_response[:transaction][:user_id]).to eq user.id
        expect(json_response[:transaction][:book_id]).to eq book.id
        expect(json_response[:transaction][:returned_at]).to be_present
      end
    end

    context "with invalid parameters" do
      it "does not update a transaction" do
        post(
          return_api_v1_transactions_path,
          params: { user_id: user.id, book_id: nil },
          headers: { 'Authorization' => "#{token_for_user(user)}" }
        )
        expect(response).to have_http_status(:not_found)
        expect(json_response[:error]).to eq "Couldn't find Book without an ID"
      end
    end
  end
end
