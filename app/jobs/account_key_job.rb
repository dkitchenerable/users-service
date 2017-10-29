class AccountKeyJob < ActiveJob::Base
  queue_as :default

  rescue_from(AccountKeyService::AccountApiUnavailable) do
    retry_job wait: 5.minutes, queue: :default
  end

  def perform(args)
    AccountKeyService.new(args[:id]).run
  end
end
