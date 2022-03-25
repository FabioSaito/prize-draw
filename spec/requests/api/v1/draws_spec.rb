require 'swagger_helper'

RSpec.describe 'api/v1/draws', type: :request do

  path '/api/v1/draws' do
    get('list draws') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create draw') do
      security [ Token: [] ]
      response(200, 'successful') do
        let(:Authorization) { "Bearer SecurePassword321" }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Access denied') do
        let(:Authorization) { "Bearer SecurePassword32" }
        
        after do |example|
          puts response.body
          example.metadata[:response][:content] = {
            'application/json' => {
              example: response.body
            }
          }
        end
        run_test!
      end


    end
  end
end
