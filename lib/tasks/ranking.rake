namespace :ranking do
  desc "Daily update of the world Ranking"
  task update_all: :environment do
    RefreshRankingJob.perform_later
  end
end
