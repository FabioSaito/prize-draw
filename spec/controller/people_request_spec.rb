require 'rails_helper'

RSpec.describe 'Api::V1::PeopleController', type: :request do
  fixtures :people

  describe 'GET /index' do
    describe 'when table is populated' do 
      before { get api_v1_people_path }

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end
      
      it 'retuns all elements from Person table' do
        expect(response.body).to include(*Person.pluck(:name))
      end
    end

    describe 'when table is empty' do 
      before do
        Person.delete_all
        get api_v1_people_path 
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end
      
      it 'returns no element from Person table' do
        expect(response.body).to eq('[]')
      end
    end
  end

  describe 'GET /show' do
    let(:selected_person) { people(:lucky1) }
    before { get api_v1_person_path(selected_person.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    
    it 'returns correct person' do
      expect(response.body).to include(selected_person.name)
    end
  end

  describe 'POST /create' do
    describe 'when valid person' do
      before do 
        valid_person_post_body = { name: 'Valid Person Test', cpf: '000.000.000-00' }
        post api_v1_people_path, params: { person: valid_person_post_body }
      end
  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      
      it 'creates valid person' do
        expect(response.body).to include('Valid Person Test', '000.000.000-00')
      end
    end
    
    describe 'when invalid person' do
      before do 
        invalid_person_post_body = { name: 'Invalid Person Test', cpf: '111.111.111-11' }
        post api_v1_people_path, params: { person: invalid_person_post_body }
      end
  
      it 'returns http error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      it 'does not create invalid person' do
        expect(response.body).to include( 'cpf', 'has already been taken' )
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:deleted_person) { people(:lucky1) }
    before { delete api_v1_person_path(deleted_person.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    
    it 'returns deleted person' do
      expect(response.body).to include( deleted_person.cpf )
    end
  end

  describe 'PUT /update' do
    let(:updated_person) { people(:lucky1) }

    describe 'when valid attributes' do
      before do 
        valid_attributes = { cpf: '000.000.000-00' }
        put api_v1_person_path(updated_person.id), params: { person: valid_attributes }
      end
  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
      
      it 'updates person attributes' do
        expect(response.body).to include('000.000.000-00')
      end
    end
    
    describe 'when invalid attributes' do
      before do 
        invalid_attributes = { cpf: '222.222.222-22' }
        put api_v1_person_path(updated_person.id), params: { person: invalid_attributes }
      end
  
      it 'returns http error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      it 'does not update person attributes' do
        expect(response.body).to include( 'cpf', 'has already been taken' )
      end
    end
  end
end
