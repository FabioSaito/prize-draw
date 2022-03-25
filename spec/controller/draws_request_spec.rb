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
end
