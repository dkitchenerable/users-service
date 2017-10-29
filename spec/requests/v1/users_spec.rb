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

  describe 'POST /v1/users' do
    let(:post_params) { generate_params }
    let(:insufficient_params) { post_params.delete(:email) }

    context 'valid creation' do
      before { post '/v1/users', params: post_params}

      it 'creates a user' do
        expect(get_json['email']).to eq(post_params[:email])
        expect(get_json['phone_number']).to eq(post_params[:phone_number])
        expect(get_json['key']).to_not be_empty
        expect(get_json['account_key']).to be_nil
        expect(get_json['metadata']).to be_nil
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the params are insufficient' do
      before { post '/v1/users', params: insufficient_params }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a ' do
        expect(get_json["errors"].size).to eq(3)
        expect(get_json["errors"]).to_not be_empty
        expect(get_json["errors"]).to include("Email can't be blank")
        expect(get_json["errors"]).to include("Phone number can't be blank")
        expect(get_json["errors"]).to include("Password can't be blank")
      end
    end
  end

  private

  def generate_params
    {
      email: Faker::Internet.email,
      password: Faker::Number.number(10),
      phone_number:  Faker::Internet.password(10)
    }
  end

  def get_json
    JSON.parse(response.body)
  end
end
