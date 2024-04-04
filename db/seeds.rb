
                




# Create a main sample user.
User.create!(first_name: "Admin User",
                email: "superadmin3@datingapp.com",
                location_attributes: { country: "Philippines",
                                        state_region: "Region III",
                                        city: "Hagonoy"},
                password: "123456",
                password_confirmation: "123456",
                admin: true)
                
#session = Session.create!(user: admin)