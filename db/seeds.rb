# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative '../app/controllers/modules/add_axie.rb'
require_relative '../app/controllers/modules/exchange.rb'
require_relative '../app/controllers/modules/coin.rb'
require_relative '../app/controllers/modules/info.rb'

User.destroy_all
Battle.destroy_all
DailyEarning.destroy_all
DailyLevel.destroy_all
DailyRanking.destroy_all
Follower.destroy_all
Currency.destroy_all

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

address_1 = "ronin:805d40d62c9d8f5965ffa8d43cb1d03f7130dba4".gsub!("ronin:", "0x")
address_2 = "ronin:e530affded5adb5dfdc209b7e9b9439384b95189".gsub!("ronin:", "0x")
address_3 = "ronin:642de1680ed811bc34b52115ceeca3a66d147fa3".gsub!("ronin:", "0x")
address_4 = "ronin:fee2bc9766eca6fecc90b21f9b19172ee333ed1b".gsub!("ronin:", "0x")
address_5 = "ronin:aa00fcfc595e8b1e3d5fdfbbdd489f63a6f227c1".gsub!("ronin:", "0x")

addresses =[address_1, address_2, address_3, address_4, address_5]

Team.create!(
      user_id: User.all[0].id,
      ronin_address: address_1,
      mmr: AXIEAPI.add_metrics(address_1)["mmr"],
      rank: AXIEAPI.add_metrics(address_1)["rank"],
      current_slp: AXIEAPI.add_metrics(address_1)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_1)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_1)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_1)["next_claim"],
      scholar_name: "Nico"
    )

Team.create!(
      user_id: User.all[1].id,
      ronin_address: address_2,
      mmr: AXIEAPI.add_metrics(address_2)["mmr"],
      rank: AXIEAPI.add_metrics(address_2)["rank"],
      current_slp: AXIEAPI.add_metrics(address_2)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_2)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_2)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_2)["next_claim"],
      scholar_name: "Jerwin"
    )

Team.create!(
      user_id: User.all[2].id,
      ronin_address: address_3,
      mmr: AXIEAPI.add_metrics(address_3)["mmr"],
      rank: AXIEAPI.add_metrics(address_3)["rank"],
      current_slp: AXIEAPI.add_metrics(address_3)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_3)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_3)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_3)["next_claim"],
      scholar_name: "Amfx"
    )

Team.create!(
      user_id: User.all[3].id,
      ronin_address: address_4,
      mmr: AXIEAPI.add_metrics(address_4)["mmr"],
      rank: AXIEAPI.add_metrics(address_4)["rank"],
      current_slp: AXIEAPI.add_metrics(address_4)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_4)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_4)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_4)["next_claim"],
      scholar_name: "Raultite"
    )

Team.create!(
      user_id: User.all[4].id,
      ronin_address: address_5,
      mmr: AXIEAPI.add_metrics(address_5)["mmr"],
      rank: AXIEAPI.add_metrics(address_5)["rank"],
      current_slp: AXIEAPI.add_metrics(address_5)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_5)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_5)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_5)["next_claim"],
      scholar_name: "PatPat"
    )

puts "#{Team.count} teams were created"

unless AXIEAPI.add_axies(addresses.first).nil?

  addresses.each do |address|
    AXIEAPI.add_axies(address)["data"]["axies"]["results"].each do |axie|
      axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
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

unless AXIEAPI.add_battles(addresses.first).nil?
  addresses.each do |address|
    AXIEAPI.add_battles(address)["battles"].each do |battle|
      battle_id = battle["battle_uuid"]
      result = battle["winner"] == address ? "won" : "lost"

      new_mmr = 0
      old_mmr = 0

      battle["eloAndItem"].each do |player|
        if player["player_id"] == address
          new_mmr = player["new_elo"]
          old_mmr = player["old_elo"]
        end
      end

      Battle.create(
        result: result,
        battle_uuid: battle_id,
        ronin_address: address,
        new_mmr: new_mmr,
        old_mmr: old_mmr
      )
    end
  end
end

puts "#{Battle.count} Battles were created"

addresses.each do |address|
  team = Team.where(ronin_address: address)[0]
  team.win_rate = AXIEAPI.check_win_rate(team)
  team.save
end

puts "Win rate updated"

addresses.each do |address|

  DailyEarning.create(daily_slp: 100, date: Date.today, ronin_address: address)
  DailyEarning.create(daily_slp: 150, date: Date.today - 1, ronin_address: address)
  DailyEarning.create(daily_slp: 200, date: Date.today - 2, ronin_address: address)
  DailyEarning.create(daily_slp: 100, date: Date.today - 3, ronin_address: address)

  DailyLevel.create(mmr: 1500, date: Date.today, ronin_address: address)
  DailyLevel.create(mmr: 1450, date: Date.today - 1, ronin_address: address)
  DailyLevel.create(mmr: 1600, date: Date.today - 2, ronin_address: address)
  DailyLevel.create(mmr: 1700, date: Date.today - 3, ronin_address: address)

  DailyRanking.create(rank: 200000, date: Date.today, ronin_address: address)
  DailyRanking.create(rank: 300000, date: Date.today - 1, ronin_address: address)
  DailyRanking.create(rank: 250000, date: Date.today - 2, ronin_address: address)
  DailyRanking.create(rank: 225000, date: Date.today - 3, ronin_address: address)

end

puts "Daily metrics updated as well"
