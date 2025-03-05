require 'swagger_helper'

describe 'Books API' do
  path '/api/v1/books/{id}/income' do
    get 'Return book income for a given time period' do
      tags 'Books'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'BookId', required: true
      parameter name: :start_at, in: :query, type: :string, description: 'Start date of book income report', required: true, default: Time.now.strftime('%Y-%m-%d')
      parameter name: :end_at, in: :query, type: :string, description: 'End date of book income report', required: true, default: 1.year.from_now.strftime('%Y-%m-%d')
      security [ bearerAuth: [] ]

      response '200', 'return book income' do
        let(:id) { create(:book).id }
        let(:start_at) { '2021-01-01' }
        let(:end_at) { '2021-12-31' }
        run_test!
      end

      response '404', 'book not found' do
        let(:id) { create(:book).id }
        let(:start_at) { '2021-01-01' }
        let(:end_at) { '2021-12-31' }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:book).id }
        let(:start_at) { '2021-01-01' }
        let(:end_at) { '2021-12-31' }
        run_test!
      end
    end
  end

  path '/api/v1/books/' do
    get 'Return books' do
      tags 'Books'
      consumes 'application/json'
      produces 'application/json'
      security [ bearerAuth: [] ]

      response '200', 'return books' do
        run_test!
      end
    end
  end
end
