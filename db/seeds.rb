# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Battle.destroy_all
DailyEarning.destroy_all
DailyLevel.destroy_all
DailyRanking.destroy_all
Follower.destroy_all
Currency.destroy_all
Ranking.destroy_all
Tweet.destroy_all


puts "DB cleaned!"
# user = User.create!(email: "dummy@gmail.com", password: "123456", first_name: "Dummy", last_name: "2.0", user_name: "I_am_a_Dummy")

avatars = [
  'https://images.unsplash.com/photo-1491349174775-aaafddd81942?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGVyc29ufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1500048993953-d23a436266cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60'
]


10.times do
  user = User.create!(
    username: "Anonymous#{rand(1..9999)}",
    email: Faker::Internet.email,
    password: 123456,
    photo: avatars.sample
  )
  #file1 = URI.open(avatars.sample)
  #user.photo.attach(io: file1, filename: user.username, content_type: 'image/jpeg')
end

puts "#{User.count} users were created"

#test
#added extra line

addresses = {
  address_1: "ronin:805d40d62c9d8f5965ffa8d43cb1d03f7130dba4".gsub!("ronin:", "0x"),
  address_2: "ronin:e530affded5adb5dfdc209b7e9b9439384b95189".gsub!("ronin:", "0x"),
  address_3: "ronin:642de1680ed811bc34b52115ceeca3a66d147fa3".gsub!("ronin:", "0x")
}

addresses.each do |address_name, address|
  if !AxieApi.new.add_axies(address).nil?
    AxieApi.new.add_axies(address)["data"]["axies"]["results"].each do |axie|
      axie_genes = AxieApi.new.add_genes_to_axie(axie["id"].to_i)
      Pet.create!(
        team_id: Team.where(ronin_address: address)[0].id,
        image: axie["image"],
        axie_game_id: axie_genes["story_id"],
        name: axie_genes["name"],
        hp: axie_genes["stats"]["hp"],
        morale: axie_genes["stats"]["morale"],
        speed: axie_genes["stats"]["speed"],
        skill: axie_genes["stats"]["skill"],
        axie_class: axie_genes["class"],
        eyes: axie_genes["parts"][0]["name"],
        ears: axie_genes["parts"][1]["name"],
        back: axie_genes["parts"][2]["name"],
        mouth: axie_genes["parts"][3]["name"],
        horn: axie_genes["parts"][4]["name"],
        tail: axie_genes["parts"][5]["name"]
      )
    end
  end
end

puts "#{Pet.count} Axies were created"

metrics = AxieApi.new

addresses.each do |address_name, address|
  temp_metrics = metrics.add_metrics(address)
  Team.create!(
    user_id: User.all[0].id,
    ronin_address: address,
    mmr: temp_metrics["mmr"],
    rank: temp_metrics["rank"],
    current_slp: temp_metrics["total_slp"],
    total_slp: temp_metrics["raw_total"],
    last_claim: temp_metrics["last_claim"],
    next_claim: temp_metrics["next_claim"],
    scholar_name: "Scholar#{rand(1..9999)}",
    manager_share: 0.5
  )
end

puts "#{Team.count} teams were created"

battles = AxieApi.new
battles_hash = {}
battles_array = []
battles_hash_elo = {}

addresses.each do |address_name, address|
  battles_hash["#{address}"] = battles.add_battles(address)["battles"]
end

battles_hash.each do |address, battles|
  @current_address = address
  battles.each do |battle|
    battle_id = battle["battle_uuid"]
    battle["winner"] == @current_address ? result = "won" : result = "lost"
    battles_hash_elo[battle_id] = battle["eloAndItem"]
    Battle.create!(
      result: result,
      battle_uuid: battle_id,
      ronin_address: @current_address,
      )
  end
end

Battle.all.each do |battle|

  @new_mmr = 0
  @old_mmr = 0

  battles_hash_elo[battle[:battle_uuid]].each do |player|
    if player["player_id"] == battle[:ronin_address]
      @new_mmr = player["new_elo"]
      @old_mmr = player["old_elo"]
    end
  end
  battle[:new_mmr] = @new_mmr
  battle[:old_mmr] = @old_mmr
  battle.save
end


puts "#{Battle.count} Battles were created"

addresses.each do |address_name, address|
  team = Team.where(ronin_address: address)[0]
  team.win_rate = AxieApi.new.check_win_rate(team)
  team.save
end

puts "Win rate updated"

addresses.each do |address_name, address|

  DailyEarning.create(daily_slp: 100, date: Date.today - 20, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 19, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 18, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 17, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 16, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 15, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 14, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 13, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 12, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 11, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 10, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 9, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 8, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 7, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 6, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 5, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 4, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 3, ronin_address: address)
  DailyEarning.create(daily_slp: 200, date: Date.today - 2, ronin_address: address)
  DailyEarning.create(daily_slp: 150, date: Date.today - 1, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today, ronin_address: address)

  DailyLevel.create(mmr: 1450, date: Date.today - 20, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 19, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 18, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 17, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 16, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 15, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 14, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 13, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 12, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 11, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 10, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 9, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 8, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 7, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 6, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 5, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 4, ronin_address: address)
  DailyLevel.create(mmr: 1700, date: Date.today - 3, ronin_address: address)
  DailyLevel.create(mmr: 1600, date: Date.today - 2, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 1, ronin_address: address)
  DailyLevel.create(mmr: 1500, date: Date.today, ronin_address: address)

  DailyRanking.create(rank: 225000, date: Date.today - 20, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 19, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 18, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 17, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 16, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 15, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 14, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 13, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 12, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 11, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 10, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 9, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 8, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 7, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 6, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 5, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 4, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 3, ronin_address: address)
  DailyRanking.create(rank: 250000, date: Date.today - 2, ronin_address: address)
  DailyRanking.create(rank: 300000, date: Date.today - 1, ronin_address: address)
  DailyRanking.create(rank: 200000, date: Date.today, ronin_address: address)

end

puts "Daily metrics updated as well"
