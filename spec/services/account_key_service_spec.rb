require 'rails_helper'

describe AccountKeyService do
  context "a valid response" do
    it "returns users email and generated account key" do
       mock_params = {
           email: "foo@bar.com",
           account_key: "6dd19673329f532f884120da833e6e5d"
       }
       VCR.use_cassette 'service/api_response' do
          user = FactoryBot.create(:user, email: mock_params[:email])
          user.update_attribute(:key, "randomkey")
          service = AccountKeyService.new(user.id)
          response = service.call_api
          parsed_response = JSON.parse(response.body)
          expect(parsed_response["email"]).to eq(mock_params[:email])
          expect(parsed_response["account_key"]).to eq(mock_params[:account_key])
       end
    end
  end
end
