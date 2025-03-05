require 'swagger_helper'

describe 'Users API' do
  path '/api/v1/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string },
              email_address: { type: :string },
              password: { type: :string },
              balance: { type: :number }
            },
            required: [ 'name', 'email_address', 'balance', 'password' ]
          }
        },
        required: [ 'user' ]
      }

      request_body_example value: { user: { name: 'Peter Parker', email_address: 'peter@parker.com', password: 'passsword', balance: 100  } }, name: 'valid_example', summary: 'Valid request example'
      request_body_example value: { user: { name: '', email_address: '', password: 'passsword', balance: 100  } }, name: 'invalid_example', summary: 'Invalid request example'

      response '201', 'user created' do
        let(:user_params) { { user: { name: 'Peter Parker', email_address: 'peter@parker.com', password: 'passsword', balance: 100  } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user_params) { { user: { name: 'Peter Parker', email_address: '', password: 'passsword', balance: 100  } } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/account' do
    get 'returns user details' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      security [ bearerAuth: [] ]

      request_body_example value: { id: 1 }, name: 'valid_example', summary: 'Valid request example'

      response '200', 'user found' do
        let(:id) { create(:user).id }
        let(:Authorization) { "Bearer #{token_generator(create(:user).id)}" }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:id) { create(:user).id }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/report' do
    get 'returns user report' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      security [ bearerAuth: [] ]

      request_body_example value: { id: 1 }, name: 'valid_example', summary: 'Valid request example'

      response '200', 'user found' do
        let(:id) { create(:user).id }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:id) { create(:user).id }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/session' do
    post 'Login user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email_address: { type: :string },
          password: { type: :string }
        },
        required: [ 'email_address', 'password' ]
      }

      request_body_example value: { email_address: 'peter@parker.com', password: 'passsword' }, name: 'valid_example', summary: 'Valid request example'
      request_body_example value: { email_address: 'peter@parker.com', password: 'pas' }, name: 'invalid_example', summary: 'Invalid request example'

      response '200', 'authenticated' do
        let(:params) { { email_address: 'peter@parker.com', password: 'passsword' } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:params) { { email_address: 'peter@parker.com', password: 'pass' } }
        run_test!
      end
    end
  end
end
