require 'rails_helper'

# leverage shoulda matching!
RSpec.describe User, type: :model do
  context "model validations" do
    # necessary to bypass not null contraint
    subject { FactoryBot.create(:user) }

    it { should validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email)}
    it { should validate_length_of(:email).is_at_most(200) }

    it { should validate_presence_of(:phone_number)}
    it { should validate_uniqueness_of(:phone_number).case_insensitive}
    it { should validate_length_of(:phone_number).is_at_most(20) }

    it { should validate_length_of(:full_name).is_at_most(200) }

    it { should validate_presence_of(:password)}
    it { should validate_length_of(:password).is_at_most(100) }

    it { should validate_uniqueness_of(:account_key)}
    it { should validate_length_of(:account_key).is_at_most(100) }

    it { should validate_length_of(:metadata).is_at_most(2000) }
  end
end
