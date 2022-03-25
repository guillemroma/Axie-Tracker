# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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


10.times do
  user = User.create!(
    username: "Anonymous#{rand(1..1000)}",
    email: Faker::Internet.email,
    password: 123456,
    photo: avatars.sample
  )
  #file1 = URI.open(avatars.sample)
  #user.photo.attach(io: file1, filename: user.username, content_type: 'image/jpeg')
end

puts "#{User.count} users were created"


#user = User.all




#puts "#{Team.count} teams were created"

# 30.times do
#   project =  Project.create!(
#     title: Faker::Lorem.paragraph(sentence_count: 1),
#     description: Faker::Lorem.paragraph(sentence_count: 15),
#     location: Faker::Address.city,
#     category_id: category.sample.id,
#     user_id: User.all.sample.id
#   )
#   file1 = URI.open(projects.sample)
#   file2 = URI.open(projects.sample)


#   project.photos.attach([{ io: file1, filename: project.title, content_type: 'image/jpeg' },
#     { io: file2, filename: project.title, content_type: 'image/jpeg' }])
# end

# puts "#{Project.count} projects were created"

# Skill.create!(name: "Music")
# Skill.create!(name: "Reading")
# Skill.create!(name: "Gardening")
# Skill.create!(name: "Dancing")
# Skill.create!(name: "Painting")
# Skill.create!(name: "Movies")
# Skill.create!(name: "Magic")
# Skill.create!(name: "Sports")
# Skill.create!(name: "Hiking")
# Skill.create!(name: "Fishing")
# Skill.create!(name: "Computer Games")
# Skill.create!(name: "Bitcoin")
# Skill.create!(name: "Traveling")
# Skill.create!(name: "Knitting")
# Skill.create!(name: "Sewing")
# Skill.create!(name: "Playing Cards")
# Skill.create!(name: "Chess")
# Skill.create!(name: "Chatting")

# puts "#{Skill.count} interests were created"
