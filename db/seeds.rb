# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Major
Major.create!( :name => "中文系" )
Major.create!( :name => "外文系" )
Major.create!( :name => "音樂系" )
Major.create!( :name => "劇藝系" )
Major.create!( :name => "生科系" )
Major.create!( :name => "化學系" )
Major.create!( :name => "物理系" )
Major.create!( :name => "應數系" )
Major.create!( :name => "電機系" )
Major.create!( :name => "機電系" )
Major.create!( :name => "資工系" )
Major.create!( :name => "光電系" )
Major.create!( :name => "材光系" )
Major.create!( :name => "企管系" )
Major.create!( :name => "資管系" )
Major.create!( :name => "財管系" )
Major.create!( :name => "海資系" )
Major.create!( :name => "海工系" )
Major.create!( :name => "海科系" )
Major.create!( :name => "政經系" )
Major.create!( :name => "社會系" )
#Major.create!( :name => "CHINESE LITERATURE" )
#Major.create!( :name => "FOREIGN LANGUAGES AND LITERATURE" )
#Major.create!( :name => "MUSIC" )
#Major.create!( :name => "THEATRE ARTS" )
#Major.create!( :name => "BIOLOGICAL SCIENCES" )
#Major.create!( :name => "CHEMISTRY" )
#Major.create!( :name => "PHYSICS" )
#Major.create!( :name => "APPLIED MATHEMATICS" )
#Major.create!( :name => "ELECTRICAL ENGINEERING" )
#Major.create!( :name => "MECHANICAL AND ELECTRO-MECHANICAL ENGINEERING" )
#Major.create!( :name => "COMPUTER SCIENCE AND ENGINEERING" )
#Major.create!( :name => "PHOTONICS" )
#Major.create!( :name => "MATERIALS AND OPTOELECTRONIC SCIENCE" )
#Major.create!( :name => "BUSINESS MANAGEMENT" )
#Major.create!( :name => "INFORMATION MANAGEMENT" )
#Major.create!( :name => "FINANCE" )
#Major.create!( :name => "MARINE BIOTECHNOLOGY AND RESOURCES" )
#Major.create!( :name => "MARINE ENVIRONMENT AND ENGINEERING" )
#Major.create!( :name => "OCEANOGRAPHY" )
#Major.create!( :name => "POLITICAL ECONOMY" )
#Major.create!( :name => "SOCIOLOGY" )rails generate controller Microposts


#Sex
Sex.create!( :name => "Male" )
Sex.create!( :name => "Female" )
Sex.create!( :name => "Others" )

User.create!(name:  "Admin",
             email: "qazbnm456@gmail.com",
             password:              "aaaaaaaa",
             password_confirmation: "aaaaaaaa",
             major_id: 1,
             sex_id: 1,
             admin:     true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password:              password,
               password_confirmation: password,
               major_id: 1,
               sex_id: 1)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end