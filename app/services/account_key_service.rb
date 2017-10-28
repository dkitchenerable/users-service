class AccountKeyService
  def initialize(user_id)
    @user = User.find(user_id)
  end

  def run
    # call service and raise if not created
  end

  private 

  attr_reader :user
end
