require 'rails_helper'

describe UserFetchService do
  context "nil query" do
    let(:service) { UserFetchService.new({})}
    it "should return all records" do
      user = FactoryBot.create(:user)
      results = service.results
      expect(results.size).to eq(1)
      expect(results[:users].object.first.id).to eq(user.id)
    end
  end

  context "with query param" do
    let(:service) { UserFetchService.new({query: "foo"})}
    it "should delegate to search service" do
      allow(User).to receive(:search).and_return(Sunspot::Rails::StubSessionProxy::Search.new)
      results = service.results
      expect(results).to be_empty
      expect(User).to have_received(:search)
    end
  end
end
