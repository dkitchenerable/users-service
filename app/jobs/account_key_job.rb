class AccountKeyJob < ActiveJob::Base
  queue_as :default

  rescue_from(AccountKeyService::AccountApiUnavailable) do
    retry_job wait: 5.minutes, queue: :default
  end

  def perform(user_id)
    AccountKeyService.new(user_id).run
  end
end
