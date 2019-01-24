User.create!(name: "Example User",
        email: "example@example.com",
        password: "foobar",
        password_confirmation: "foobar",
        admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name: name,
        email: email, 
        password: password,
        password_confirmation: password)
end

user = User.first
user.tasks.create!(title: Faker::Lorem.word, start: Time.mktime(2019, 1, 5, 00, 00, 00), end: Time.mktime(2019, 1, 7, 00, 00, 00))
user.tasks.create!(title: Faker::Lorem.word, start: Time.mktime(2019, 1, 10, 8, 30, 00), end: Time.mktime(2019, 1, 10, 12, 00, 00))
user.tasks.create!(title: Faker::Lorem.word, start: Time.mktime(2019, 1, 12, 17, 20, 00), end: Time.mktime(2019, 1, 13, 20, 00, 00))
user.tasks.create!(title: Faker::Lorem.word, start: Time.mktime(2019, 1, 13, 8, 00, 00), end: Time.mktime(2019, 1, 13, 14, 20, 00))
user.tasks.create!(title: Faker::Lorem.word, start: Time.mktime(2019, 1, 20, 12, 30, 00), end: Time.mktime(2019, 1, 20, 15, 00, 00))
user.tasks.create!(title: Faker::Lorem.word, start: Time.mktime(2019, 1, 22, 18, 45, 00), end: Time.mktime(2019, 1, 22, 22, 15, 00))