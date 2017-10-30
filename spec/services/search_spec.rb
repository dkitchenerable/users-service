require 'rails_helper'

describe Search, search: true do
  let(:service) { Search.new("foo")}

  context "search error" do
    it "should raise malformed error" do
      allow(User).to receive(:search).and_raise(Sunspot::IllegalSearchError)
      expect{service.results}.to raise_error(MalformedError)
    end
  end

  context "no user match" do
    it "should return results" do
      user1 = FactoryBot.create(:user, metadata:"bar")
      Sunspot.commit
      expect(service.results).to be_empty
    end
  end

  context "matches user" do
    it "should return results" do
      user1 = FactoryBot.create(:user, metadata:"foo")
      user2 = FactoryBot.create(:user, metadata:"bar")
      Sunspot.commit
      results = service.results
      expect(results).to_not be_empty
      expect(results.size).to eq(1)
    end
  end

  context "matches mutiple users in same field" do
    it "should return results" do
      user1 = FactoryBot.create(:user, metadata:"foo")
      user2 = FactoryBot.create(:user, metadata:"foo bar")
      Sunspot.commit
      results = service.results
      expect(results).to_not be_empty
      expect(results.size).to eq(2)
    end
  end

  context "matches mutiple users across fields" do
    it "should return results" do
      user1 = FactoryBot.create(:user, email:"foo@bar.com")
      user2 = FactoryBot.create(:user, metadata:"friend of foo@bar.com")
      Sunspot.commit
      results = service.results
      expect(results).to_not be_empty
      expect(results.size).to eq(2)
    end
  end  
end
