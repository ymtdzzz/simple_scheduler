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

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.word
  users.each { |user| user.tasks.create!(title: title, start: Time.mktime(2019, 1, 5), end: Time.mktime(2019, 1, 7))}
end