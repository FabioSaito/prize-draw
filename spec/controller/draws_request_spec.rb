require 'rails_helper'

RSpec.describe 'Api::V1::DrawsController', type: :request do
  fixtures :people, :draws

  describe 'GET /index' do
    before(:all) { get api_v1_draws_path }

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
    
    it 'includes winner and created_at' do
      expect(response.body).to include('winner', 'created_at')
    end
  end

  describe 'POST /create' do
    before(:all) do
      post api_v1_draws_path, headers: {Authorization: 'Bearer SecurePassword321'}
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    
    it 'show selected person on response' do
      expect(response.body).to include('name')
    end
    
    it 'removes winner from prize draw pool' do
      winner = JSON.parse(response.body, symbolize_names: true)
      expect{ Person.find_by!(name: winner[:name]) }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end





  # describe 'DELETE /destroy' do
  #   let(:deleted_person) { people(:lucky1) }
  #   before { delete api_v1_person_path(deleted_person.id) }

  #   it 'returns http success' do
  #     expect(response).to have_http_status(:success)
  #   end
    
  #   it 'returns deleted person' do
  #     expect(response.body).to include( deleted_person.cpf )
  #   end
  # end

  # describe 'PUT /update' do
  #   let(:updated_person) { people(:lucky1) }

  #   describe 'when valid attributes' do
  #     before do 
  #       valid_attributes = { cpf: '000.000.000-00' }
  #       put api_v1_person_path(updated_person.id), params: { person: valid_attributes }
  #     end
  
  #     it 'returns http success' do
  #       expect(response).to have_http_status(:success)
  #     end
      
  #     it 'update person attributes' do
  #       expect(response.body).to include('000.000.000-00')
  #     end
  #   end
    
  #   describe 'when invalid attributes' do
  #     before do 
  #       invalid_attributes = { cpf: '222.222.222-22' }
  #       put api_v1_person_path(updated_person.id), params: { person: invalid_attributes }
  #     end
  
  #     it 'returns http error' do
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
      
  #     it 'do not update person attributes' do
  #       expect(response.body).to include( 'cpf', 'has already been taken' )
  #     end
  #   end
  # end
end
