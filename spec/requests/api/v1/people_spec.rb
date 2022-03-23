require 'swagger_helper'

RSpec.describe 'api/v1/people', type: :request do

  path '/api/v1/people' do

    get('list people') do
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

    post('create person') do
      consumes 'application/json'
      parameter name: :person, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          cpf: { type: :string }
        },
        required: [ 'name', 'cpf' ]
      }

      response(200, 'successful') do
        let(:person) { { name: 'Joao do Teste', cpf: '911.222.333-44' } }
        
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'error') do
        let(:person) { { name: 'Joao do Teste' } }

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
  end

  path '/api/v1/people/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: :person, in: :body, schema: {
      type: :object,
      properties: {
        name: { type: :string },
        cpf: { type: :string }
      },
      required: [ 'name', 'cpf' ]
    }
    

    get('show person') do
      response(200, 'successful') do
        let(:id) { '2' }

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

    put('update person') do
      response(200, 'successful') do
        consumes 'application/json'
        let(:id) { '2' }
        let(:person) { { name: 'Maria do Teste', cpf: '123' } }

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

    delete('delete person') do
      response(200, 'successful') do
        let(:id) { '2' }

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

  end
end