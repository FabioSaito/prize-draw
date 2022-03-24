require 'swagger_helper'

RSpec.describe 'swagger_helper', type: :request do
  fixtures :people

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
        let(:person) { { name: 'Test Person', cpf: '911.222.333-44' } }
        
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
        let(:person) { { name: 'Test Person' } }

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
    let(:id) { people(:lucky1).id }

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
      consumes 'application/json'
      response(200, 'successful') do
        let(:person) { { name: 'New Test Name', cpf: '123' } }

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
        let(:person) { { name: '' } }

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
