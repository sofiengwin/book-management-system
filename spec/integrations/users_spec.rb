require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:valid_attributes) {
    { user: { name: 'Peter Parker', email_address: 'peter@parker.com', password: 'passsword', balance: 100.0  } }
  }
  let(:invalid_attributes) {
    { user: { name: 'Peter Parker', email_address: '', password: 'passsword', balance: 100.0  } }
  }
  let(:user) { create(:user) }

  describe "POST /users" do
    context "with valid parameters" do
      it "creates user" do
        post api_v1_users_path, params: valid_attributes, headers: {}
        expect(response).to have_http_status(:created)
        expect(json_response[:user_id]).to be_present
        expect(json_response[:balance]).to eq "100.0"
      end
    end

    context "with invalid parameters" do
      it "does not creates user" do
        post api_v1_users_path, params: invalid_attributes, headers: {}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:error]).to eq [ "Email address is invalid" ]
      end
    end
  end

  describe "GET /users/:id/account" do
    let(:book) { create(:book) }

    context 'with valid credentials' do
      it "returns user" do
        create(:transaction, user: user, book: book)
        get account_api_v1_user_path(user), headers: { 'Authorization': "#{token_for_user(user)}" }
        expect(response).to have_http_status(:success)
        expect(json_response[:balance]).to eq "100.0"
        expect(json_response[:borrowed_books].length).to eq 1
        expect(json_response[:borrowed_books][0][:title]).to eq 'Oliver Twist'
        expect(json_response[:borrowed_books][0][:author]).to eq 'Charles Dickens'
        expect(json_response[:borrowed_books][0][:genre]).to eq 'Fiction'
      end
    end

    context 'with invalid credentials' do
      it "returns unauthorized" do
        create(:transaction, user: user, book: book)
        get account_api_v1_user_path(user), headers: { 'Authorization': "" }
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to eq "Unauthorized"
      end
    end
  end

  describe "GET /users/:id/report" do
    let(:book) { create(:book) }
    context 'only includes transactions within the last month belonging to the user' do
      before do
        [ 5, 10, 25 ].each do |num|
          create(:transaction, book: create(:book), user: user, fee_charged: num, borrowed_at: num.days.ago)
        end
      end

      it 'calculates mothly report' do
        create(:transaction, book: book, user: create(:user, email_address: 'bruce@banner.com'), fee_charged: 10.0)
        get report_api_v1_user_path(user), params: { report_type: 'monthly' }, headers: { 'Authorization': "#{token_for_user(user)}" }
        expect(response).to have_http_status(:success)
        expect(json_response[:total_spent]).to eq '40.0'
        expect(json_response[:books_borrowed]).to eq 3
      end
    end
  end
end
