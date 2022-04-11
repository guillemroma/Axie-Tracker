namespace :team do
  desc "Update of user ranking every 10 minutes"
  task update_all: :environment do
    RefreshTeamsJob.perform_later
  end
end
