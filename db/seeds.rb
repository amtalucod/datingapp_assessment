# Create a main sample user.
User.create!(name: "Admin User",
                email: "example@railstutorial.org",
                password: "foobar",
                password_confirmation: "foobar",
                admin: true)
                

                
# Generate a bunch of additional users.
99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password)
end


#not yet implemented to DB
new_admin_data = [
  { email: 'amtalucod@example.com', password: 'skyflakes', role: 'admin' }
]

# Create new admin users, skipping existing emails
new_admin_data.each do |admin_params|
  unless User.exists?(email: admin_params[:email])
    User.create!(admin_params)
    puts "New admin user created: #{admin_params[:email]}"
  else
    puts "Skipping creation of admin user #{admin_params[:email]} as email is already taken."
  end
end