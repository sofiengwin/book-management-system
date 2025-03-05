require 'swagger_helper'

describe 'Transactions API' do
  path '/api/v1/transactions/borrow' do
    post 'Borrow a book' do
      tags 'Transactions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          book_id: { type: :integer }
        },
        required: [ 'user_id', 'book_id' ]
      }
      security [ bearerAuth: [] ]

      response '201', 'user created' do
        let(:params) { { user_id: create(:user).id, book_id: create(:book).id } }
        run_test!
      end

      response '404', 'user or book not found' do
        let(:params) { {} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:params) { { user_id: create(:user).id, book_id: create(:book).id } }
        run_test!
      end
    end
  end

  path '/api/v1/transactions/return' do
    post 'Return a book' do
      tags 'Transactions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          book_id: { type: :integer }
        },
        required: [ 'user_id', 'book_id' ]
      }
      security [ bearerAuth: [] ]

      response '201', 'user created' do
        let(:params) { { user_id: create(:user).id, book_id: create(:book).id } }
        run_test!
      end

      response '404', 'user or book not found' do
        let(:params) { {} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:params) { { user_id: create(:user).id, book_id: create(:book).id } }
        run_test!
      end
    end
  end
end
