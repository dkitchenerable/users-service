class AccountKeyService
  AccountApiUnavailable = Class.new(StandardError)

  def initialize(user_id)
    @user = User.find(user_id)
  end

  def run
    @response = call_api
    if valid_response?
      user.update_attribute(:account_key, account_key)
    else
      raise AccountApiUnavailable
    end
  end

  def call_api
    HTTParty.post(
      ENV.fetch("API_SERVICE_ENDPOINT"),
      body: {
        email: user.email,
        key:   user.key
      }.to_json,
      format: :json
    )
  end

  private

  def valid_response?
    valid_code? && !account_key.nil?
  end

  def account_key
    response.fetch("account_key")
  end

  def valid_code?
    response.code.between?(200,299)
  end

  attr_reader :user, :response
end
