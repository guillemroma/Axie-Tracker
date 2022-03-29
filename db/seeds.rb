# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/add_axie.rb'
require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/exchange.rb'
require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/coin.rb'
require '/home/guillem/code/guillemroma/Axie_tracker/app/controllers/modules/info.rb'

User.destroy_all

puts "DB cleaned!"
# user = User.create!(email: "dummy@gmail.com", password: "123456", first_name: "Dummy", last_name: "2.0", user_name: "I_am_a_Dummy")

avatars = [
  'https://images.unsplash.com/photo-1491349174775-aaafddd81942?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGVyc29ufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1500048993953-d23a436266cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60'
]


20.times do
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

address_1 = "ronin:e530affded5adb5dfdc209b7e9b9439384b95189".gsub!("ronin:", "0x")
address_2 = "ronin:805d40d62c9d8f5965ffa8d43cb1d03f7130dba4".gsub!("ronin:", "0x")
address_3 = "ronin:c048b11218664bf870decebccc8bfe0ebfa851be".gsub!("ronin:", "0x")
address_4 = "ronin:642de1680ed811bc34b52115ceeca3a66d147fa3".gsub!("ronin:", "0x")
address_5 = "ronin:fee2bc9766eca6fecc90b21f9b19172ee333ed1b".gsub!("ronin:", "0x")
address_6 = "ronin:fcfef4ebdf0a833853b4eff5955ac09a4bb64260".gsub!("ronin:", "0x")
address_7 = "ronin:fe15eaf6196c77d4a035a160670ee9657163ec48".gsub!("ronin:", "0x")
address_8 = "ronin:aa00fcfc595e8b1e3d5fdfbbdd489f63a6f227c1".gsub!("ronin:", "0x")
address_9 = "ronin:eb98a829edb22607dcdfada6d062bd42bf7cd823".gsub!("ronin:", "0x")
address_10 = "ronin:903777d9580d7cce95dfd83c85e35c9b1cd56be1".gsub!("ronin:", "0x")
address_11 = "ronin:344f64c8802f001d6f03bfd29e69c0ffe1199a6b".gsub!("ronin:", "0x")
address_12 = "ronin:b3a065b04eb09bc736e24b2eda082798dbfc5a4f".gsub!("ronin:", "0x")
address_13 = "ronin:63cc49b4eb09ee8ee18587a51c934706e763506c".gsub!("ronin:", "0x")
address_14 = "ronin:0e2d365906554bfacf626205990d392c7c5b029a".gsub!("ronin:", "0x")
address_15 = "ronin:55e5fe54677e277bac4ae9513009e1aaad115d95".gsub!("ronin:", "0x")
address_16 = "ronin:5f3783d49a09d48ab89cd6be3ada5ee6f2317366".gsub!("ronin:", "0x")
address_17 = "ronin:5a9765e0968669f91121a26be2db61e371efc4f7".gsub!("ronin:", "0x")
address_18 = "ronin:db7d85f11dc6f6c972e1325210b899e0e78e8376".gsub!("ronin:", "0x")
address_19 = "ronin:201eecc2be52f58e1af46f7e46a4bf45194d12a1".gsub!("ronin:", "0x")
address_20 = "ronin:a8e44888c1693f72d4f3296b6d393168c10753ce".gsub!("ronin:", "0x")
address_21 = "ronin:89e0bbe7e92368bb01c334f8a692fcc23a70f996".gsub!("ronin:", "0x")
address_22 = "ronin:abfc05a6ae225b35b10d119d0271d71703d53884".gsub!("ronin:", "0x")
address_23 = "ronin:2580c306665aeaaeb562d24903d449d85a26888b".gsub!("ronin:", "0x")
address_24 = "ronin:d384a7a1e1621d069ddaaf1182d328f7aa6dca3f".gsub!("ronin:", "0x")
address_25 = "ronin:2ebb539bacaec052287147593730cab8248676da".gsub!("ronin:", "0x")
address_26 = "ronin:963752ca7947f2e442684662d7a3e29ce2e3575c".gsub!("ronin:", "0x")
address_27 = "ronin:596c04001e4cd12ba9d7801f8d47d582a395dd4c".gsub!("ronin:", "0x")
address_28 = "ronin:9b05ea0cdd7298ffb2f8d075db64d98461a9d9b2".gsub!("ronin:", "0x")
address_29 = "ronin:670e7f0406d46bf03c65ed2f81a104175928dc23".gsub!("ronin:", "0x")

Team.create!(
      user_id: User.all[0].id,
      ronin_address: address_1,
      mmr: AXIEAPI.add_metrics(address_1)["mmr"],
      rank: AXIEAPI.add_metrics(address_1)["rank"],
      current_slp: AXIEAPI.add_metrics(address_1)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_1)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_1)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_1)["next_claim"],
      scholar_name: "scholar"
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
      scholar_name: "scholar"
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
      scholar_name: "scholar"
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
      scholar_name: "scholar"
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
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[5].id,
      ronin_address: address_6,
      mmr: AXIEAPI.add_metrics(address_6)["mmr"],
      rank: AXIEAPI.add_metrics(address_6)["rank"],
      current_slp: AXIEAPI.add_metrics(address_6)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_6)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_6)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_6)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[6].id,
      ronin_address: address_7,
      mmr: AXIEAPI.add_metrics(address_7)["mmr"],
      rank: AXIEAPI.add_metrics(address_7)["rank"],
      current_slp: AXIEAPI.add_metrics(address_7)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_7)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_7)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_7)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[7].id,
      ronin_address: address_8,
      mmr: AXIEAPI.add_metrics(address_8)["mmr"],
      rank: AXIEAPI.add_metrics(address_8)["rank"],
      current_slp: AXIEAPI.add_metrics(address_8)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_8)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_8)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_8)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[8].id,
      ronin_address: address_9,
      mmr: AXIEAPI.add_metrics(address_9)["mmr"],
      rank: AXIEAPI.add_metrics(address_9)["rank"],
      current_slp: AXIEAPI.add_metrics(address_9)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_9)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_9)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_9)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[9].id,
      ronin_address: address_10,
      mmr: AXIEAPI.add_metrics(address_10)["mmr"],
      rank: AXIEAPI.add_metrics(address_10)["rank"],
      current_slp: AXIEAPI.add_metrics(address_10)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_10)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_10)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_10)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[10].id,
      ronin_address: address_11,
      mmr: AXIEAPI.add_metrics(address_11)["mmr"],
      rank: AXIEAPI.add_metrics(address_11)["rank"],
      current_slp: AXIEAPI.add_metrics(address_11)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_11)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_11)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_11)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[11].id,
      ronin_address: address_12,
      mmr: AXIEAPI.add_metrics(address_12)["mmr"],
      rank: AXIEAPI.add_metrics(address_12)["rank"],
      current_slp: AXIEAPI.add_metrics(address_12)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_12)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_12)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_12)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[12].id,
      ronin_address: address_13,
      mmr: AXIEAPI.add_metrics(address_13)["mmr"],
      rank: AXIEAPI.add_metrics(address_13)["rank"],
      current_slp: AXIEAPI.add_metrics(address_13)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_13)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_13)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_13)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[13].id,
      ronin_address: address_14,
      mmr: AXIEAPI.add_metrics(address_14)["mmr"],
      rank: AXIEAPI.add_metrics(address_14)["rank"],
      current_slp: AXIEAPI.add_metrics(address_14)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_14)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_14)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_14)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[14].id,
      ronin_address: address_15,
      mmr: AXIEAPI.add_metrics(address_15)["mmr"],
      rank: AXIEAPI.add_metrics(address_15)["rank"],
      current_slp: AXIEAPI.add_metrics(address_15)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_15)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_15)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_15)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[15].id,
      ronin_address: address_16,
      mmr: AXIEAPI.add_metrics(address_16)["mmr"],
      rank: AXIEAPI.add_metrics(address_16)["rank"],
      current_slp: AXIEAPI.add_metrics(address_16)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_16)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_16)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_16)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[16].id,
      ronin_address: address_17,
      mmr: AXIEAPI.add_metrics(address_17)["mmr"],
      rank: AXIEAPI.add_metrics(address_17)["rank"],
      current_slp: AXIEAPI.add_metrics(address_17)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_17)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_17)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_17)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[17].id,
      ronin_address: address_18,
      mmr: AXIEAPI.add_metrics(address_18)["mmr"],
      rank: AXIEAPI.add_metrics(address_18)["rank"],
      current_slp: AXIEAPI.add_metrics(address_18)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_18)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_18)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_18)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[18].id,
      ronin_address: address_19,
      mmr: AXIEAPI.add_metrics(address_19)["mmr"],
      rank: AXIEAPI.add_metrics(address_19)["rank"],
      current_slp: AXIEAPI.add_metrics(address_19)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_19)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_19)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_19)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[19].id,
      ronin_address: address_20,
      mmr: AXIEAPI.add_metrics(address_20)["mmr"],
      rank: AXIEAPI.add_metrics(address_20)["rank"],
      current_slp: AXIEAPI.add_metrics(address_20)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_20)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_20)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_20)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[1].id,
      ronin_address: address_21,
      mmr: AXIEAPI.add_metrics(address_21)["mmr"],
      rank: AXIEAPI.add_metrics(address_21)["rank"],
      current_slp: AXIEAPI.add_metrics(address_21)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_21)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_21)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_21)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[1].id,
      ronin_address: address_22,
      mmr: AXIEAPI.add_metrics(address_22)["mmr"],
      rank: AXIEAPI.add_metrics(address_22)["rank"],
      current_slp: AXIEAPI.add_metrics(address_22)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_22)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_22)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_22)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[2].id,
      ronin_address: address_23,
      mmr: AXIEAPI.add_metrics(address_23)["mmr"],
      rank: AXIEAPI.add_metrics(address_23)["rank"],
      current_slp: AXIEAPI.add_metrics(address_23)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_23)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_23)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_23)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[2].id,
      ronin_address: address_24,
      mmr: AXIEAPI.add_metrics(address_24)["mmr"],
      rank: AXIEAPI.add_metrics(address_24)["rank"],
      current_slp: AXIEAPI.add_metrics(address_24)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_24)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_24)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_24)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[3].id,
      ronin_address: address_25,
      mmr: AXIEAPI.add_metrics(address_25)["mmr"],
      rank: AXIEAPI.add_metrics(address_25)["rank"],
      current_slp: AXIEAPI.add_metrics(address_25)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_25)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_25)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_25)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[3].id,
      ronin_address: address_26,
      mmr: AXIEAPI.add_metrics(address_26)["mmr"],
      rank: AXIEAPI.add_metrics(address_26)["rank"],
      current_slp: AXIEAPI.add_metrics(address_26)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_26)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_26)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_26)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[1].id,
      ronin_address: address_27,
      mmr: AXIEAPI.add_metrics(address_27)["mmr"],
      rank: AXIEAPI.add_metrics(address_27)["rank"],
      current_slp: AXIEAPI.add_metrics(address_27)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_27)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_27)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_27)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[2].id,
      ronin_address: address_28,
      mmr: AXIEAPI.add_metrics(address_28)["mmr"],
      rank: AXIEAPI.add_metrics(address_28)["rank"],
      current_slp: AXIEAPI.add_metrics(address_28)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_28)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_28)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_28)["next_claim"],
      scholar_name: "scholar"
    )

Team.create!(
      user_id: User.all[1].id,
      ronin_address: address_29,
      mmr: AXIEAPI.add_metrics(address_29)["mmr"],
      rank: AXIEAPI.add_metrics(address_29)["rank"],
      current_slp: AXIEAPI.add_metrics(address_29)["total_slp"],
      total_slp: AXIEAPI.add_metrics(address_29)["raw_total"],
      last_claim: AXIEAPI.add_metrics(address_29)["last_claim"],
      next_claim: AXIEAPI.add_metrics(address_29)["next_claim"],
      scholar_name: "scholar"
    )

puts "#{Team.count} teams were created"

AXIEAPI.add_axies(address_1)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_1)[0].id,
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


AXIEAPI.add_axies(address_2)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_2)[0].id,
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

AXIEAPI.add_axies(address_3)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_3)[0].id,
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

AXIEAPI.add_axies(address_4)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_4)[0].id,
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

AXIEAPI.add_axies(address_5)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_5)[0].id,
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

AXIEAPI.add_axies(address_6)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_6)[0].id,
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

AXIEAPI.add_axies(address_7)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_7)[0].id,
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

AXIEAPI.add_axies(address_8)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_8)[0].id,
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

AXIEAPI.add_axies(address_9)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_9)[0].id,
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

AXIEAPI.add_axies(address_10)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_10)[0].id,
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

AXIEAPI.add_axies(address_11)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_11)[0].id,
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

AXIEAPI.add_axies(address_12)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_12)[0].id,
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

AXIEAPI.add_axies(address_13)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_13)[0].id,
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

AXIEAPI.add_axies(address_14)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_14)[0].id,
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

AXIEAPI.add_axies(address_15)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_15)[0].id,
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

AXIEAPI.add_axies(address_16)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_16)[0].id,
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

AXIEAPI.add_axies(address_17)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_17)[0].id,
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

AXIEAPI.add_axies(address_18)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_18)[0].id,
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

AXIEAPI.add_axies(address_19)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_19)[0].id,
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

AXIEAPI.add_axies(address_20)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_20)[0].id,
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

AXIEAPI.add_axies(address_21)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_21)[0].id,
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

AXIEAPI.add_axies(address_22)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_22)[0].id,
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

AXIEAPI.add_axies(address_23)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_23)[0].id,
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

AXIEAPI.add_axies(address_24)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_24)[0].id,
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

AXIEAPI.add_axies(address_25)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_25)[0].id,
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

AXIEAPI.add_axies(address_26)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_26)[0].id,
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

AXIEAPI.add_axies(address_27)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_27)[0].id,
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

AXIEAPI.add_axies(address_28)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_28)[0].id,
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

AXIEAPI.add_axies(address_29)["data"]["axies"]["results"].each do |axie|

  axie_genes = AXIEAPI.add_genes_to_axie(axie["id"].to_i)
  Pet.create!(
    team_id: Team.where(ronin_address: address_29)[0].id,
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

puts "#{Pet.count} Axies were created"


if AXIEAPI.add_battles(address_1)["battles"] != nil
  AXIEAPI.add_battles(address_1)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_1 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_1)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_2)["battles"] != nil
  AXIEAPI.add_battles(address_2)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_2 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_2)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_3)["battles"] != nil
  AXIEAPI.add_battles(address_3)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_3 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_3)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_4)["battles"] != nil
  AXIEAPI.add_battles(address_4)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_4 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_4)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_5)["battles"] != nil
  AXIEAPI.add_battles(address_5)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_5 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_5)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_6)["battles"] != nil
  AXIEAPI.add_battles(address_6)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_6 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_6)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_7)["battles"] != nil
  AXIEAPI.add_battles(address_7)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_7 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_7)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_8)["battles"] != nil
  AXIEAPI.add_battles(address_8)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_8 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_8)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_9)["battles"] != nil
  AXIEAPI.add_battles(address_9)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_9 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_9)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_10)["battles"] != nil
  AXIEAPI.add_battles(address_10)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_10 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_10)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_11)["battles"] != nil
  AXIEAPI.add_battles(address_11)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_11 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_11)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_12)["battles"] != nil
  AXIEAPI.add_battles(address_12)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_12 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_12)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_13)["battles"] != nil
  AXIEAPI.add_battles(address_13)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_13 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_13)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_14)["battles"] != nil
  AXIEAPI.add_battles(address_14)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_14 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_14)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_15)["battles"] != nil
  AXIEAPI.add_battles(address_15)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_15 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_15)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_16)["battles"] != nil
  AXIEAPI.add_battles(address_16)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_16 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_16)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_17)["battles"] != nil
  AXIEAPI.add_battles(address_17)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_17 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_17)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_18)["battles"] != nil
  AXIEAPI.add_battles(address_18)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_18 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_18)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_19)["battles"] != nil
  AXIEAPI.add_battles(address_19)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_19 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_19)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_20)["battles"] != nil
  AXIEAPI.add_battles(address_20)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_20 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_20)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_21)["battles"] != nil
  AXIEAPI.add_battles(address_21)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_21 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_21)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_22)["battles"] != nil
  AXIEAPI.add_battles(address_22)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_22 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_22)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_23)["battles"] != nil
  AXIEAPI.add_battles(address_23)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_23 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_23)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_24)["battles"] != nil
  AXIEAPI.add_battles(address_24)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_24 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_24)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_25)["battles"] != nil
  AXIEAPI.add_battles(address_25)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_25 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_25)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_26)["battles"] != nil
  AXIEAPI.add_battles(address_26)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_26 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_26)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_27)["battles"] != nil
  AXIEAPI.add_battles(address_27)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_27 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_27)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_28)["battles"] != nil
  AXIEAPI.add_battles(address_28)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_28 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_28)[0].id, result: result, battle_uuid: battle_id)
  end
end

if AXIEAPI.add_battles(address_29)["battles"] != nil
  AXIEAPI.add_battles(address_29)["battles"].each do |battle|
    battle_id = battle["battle_uuid"]
    result = battle["winner"] == address_29 ? "won" : "lost"
    Battle.create(team_id: Team.where(ronin_address: address_29)[0].id, result: result, battle_uuid: battle_id)
  end
end


puts "#{Battle.count} Battles were created"

team_x_1 = Team.where(ronin_address: address_1)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_2)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_3)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_4)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_5)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_6)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_7)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_8)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_9)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_10)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_11)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_12)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_13)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_14)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_15)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_16)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_17)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_18)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_19)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_20)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_21)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_22)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_23)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_24)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_25)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_26)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_27)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_28)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

team_x_1 = Team.where(ronin_address: address_29)[0]
team_x_1.win_rate = AXIEAPI.check_win_rate(team_x_1)
team_x_1.save

puts "Win rate updated"
