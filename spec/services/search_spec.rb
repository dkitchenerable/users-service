require 'rails_helper'

describe Search do
  let(:service) { Search.new("foo")}

  context "search error" do
    it "should raise malformed error" do
      allow(User).to receive(:search).and_raise(Sunspot::IllegalSearchError)
      expect{service.results}.to raise_error(MalformedError)
    end
  end
end
