User.create!(name: ENV["NAME_ADMIN"],
                   email: ENV["EMAIL_ADMIN"],
                   password: ENV["PASS_ADMIN"],
                   password_confirmation: ENV["PASS_CONFIRM_ADMIN"],
                   admin: true,
                   activated: true,
                   activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end
