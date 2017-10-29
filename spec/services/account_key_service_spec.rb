require 'rails_helper'

describe AccountKeyService do
  let(:user) { FactoryBot.create(:user, email: mock_params[:email]) }
  context "a valid response" do
    it "returns users email and generated account key" do
       VCR.use_cassette 'service/api_response' do
          user.update_attribute(:key, "randomkey")
          service = AccountKeyService.new(user.id)
          response = service.call_api
          parsed_response = JSON.parse(response.body)
          expect(parsed_response["email"]).to eq(mock_params[:email])
          expect(parsed_response["account_key"]).to eq(mock_params[:account_key])
       end
    end
  end

  context "an invalid response" do
    it "should raise error" do
      VCR.use_cassette 'service/api_response' do
        user.update_attribute(:key, "randomkey")
        service = AccountKeyService.new(user.id)
        allow(service).to receive(:valid_response?) { false }
        expect{service.run}.to raise_error(AccountKeyService::AccountApiUnavailable)
      end
    end
  end

  private

  def mock_params
    {
      email: "foo@bar.com",
      account_key: "6dd19673329f532f884120da833e6e5d"
    }
  end

end

