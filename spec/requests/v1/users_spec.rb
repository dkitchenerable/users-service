require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /v1/users' do
    context "no users in database" do
      before { get '/v1/users' }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns empty json' do
        expect(get_json).to be_empty
      end      
    end

    context "multiple users in database" do
      let!(:users) { create_list(:user, 10) }
      before { get '/v1/users' }

      it 'returns all users' do
        expect(get_json).not_to be_empty
        expect(get_json["users"].size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

=begin
  describe 'GET /v1/users?query' do

    context 'user does not match query' do
      before { get "/v1/users?query=foo_bar" }
      let(:user) { create(:user) }
      it 'returns user ' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 0 }

      it '404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end
=end

  private

  def get_json
    JSON.parse(response.body)
  end
end
