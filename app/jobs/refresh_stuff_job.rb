class RefreshStuffJob < ApplicationJob
  queue_as :default

  def perform
    puts "starting the job"
    sleep(2)
    puts "job finished"
  end
end
