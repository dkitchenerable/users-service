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

  describe 'GET /v1/users?query' do
    context 'user matches query' do
      let!(:user) { create(:user, email: "foo_bar@email.com" ) }
      before { Sunspot.commit }
      before { get "/v1/users?query=foo_bar" }

      it 'returns user' do
        expect(get_json).not_to be_empty
        expect(get_json["users"][0]["id"]).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  private

  def get_json
    JSON.parse(response.body)
  end
end
