require 'rails_helper'

RSpec.describe AccountKeyJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(1) }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'in default queue' do
    expect(AccountKeyJob.new.queue_name).to eq('default')
  end

  it 'handles invalid id' do
    allow(AccountKeyService).to receive(:new).and_raise(AccountKeyService::AccountApiUnavailable)

    perform_enqueued_jobs do
      expect_any_instance_of(AccountKeyJob)
        .to receive(:retry_job).with(wait: 5.minutes, queue: :default)

      job
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
