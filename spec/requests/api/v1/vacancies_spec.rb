require 'rails_helper'

RSpec.describe 'Vacancies API', type: :request do
  # initialize test data 
  let!(:vacancies) { create_list(:vacancy, 10) }
  let(:vacancy_id) { vacancies.first.id }

  # Test suite for GET /vacancies
  describe 'GET /api/v1/vacancies' do
    # make HTTP get request before each example
    before { get '/api/v1/vacancies' }

    it 'returns vacancies' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
   # Test suite for GET /vacancies/:id
  describe 'GET /api/v1/vacancies/:id' do
    before { get "/api/v1/vacancies/#{vacancy_id}" }

    context 'when the record exists' do
      it 'returns the vacancy' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(vacancy_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:vacancy_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Vacancy with 'id'=100/)
      end
    end
  end
  # Test suite for POST /vacancies
  describe 'POST /api/v1/vacancies' do
    # valid payload
    let(:valid_attributes) { { title: 'web developer', salary: '10000000', requipment: 'lipsum' , description: 'lipsum', expired: '1999-09-09' } }

    context 'when the request is valid' do
      before { post '/api/v1/vacancies', params: valid_attributes }

      it 'creates a vacancy' do
        expect(json['title']).to eq('web developer')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/vacancies', params: { title: 'Foobar' , salary: '10000000', requipment: 'lipsum' , description: 'lipsum'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Expired can't be blank/)
      end
    end
  end
  # Test suite for PUT /vacancies/:id
  describe 'PUT /api/v1/vacancies/:id' do
    let(:valid_attributes) { { title: 'Admin' } }

    context 'when the record exists' do
      before { put "/api/v1/vacancies/#{vacancy_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /vacancs/:id
  describe 'DELETE /api/v1/vacancies/:id' do
    before { delete "/api/v1/vacancies/#{vacancy_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end