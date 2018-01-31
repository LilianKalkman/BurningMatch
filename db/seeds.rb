Match.destroy_all
User.destroy_all

User.create!(email:"Arno@school.com", password:"123456", admin: true)
User.create!(email:"Rembert@school.com", password:"123456", admin: true)

User.create!(email:"Oscar@school.com", password:"123456", admin: false)
User.create!(email:"Lilian@school.com", password:"123456", admin: false)
User.create!(email:"Zjan@school.com", password:"123456", admin: false)
User.create!(email:"Iryna@school.com", password:"123456", admin: false)
User.create!(email:"Nay@school.com", password:"123456", admin: false)
User.create!(email:"Tania@school.com", password:"123456", admin: false)
User.create!(email:"Erle@school.com", password:"123456", admin: false)
User.create!(email:"Danijel@school.com", password:"123456", admin: false)
User.create!(email:"Robert@school.com", password:"123456", admin: false)
User.create!(email:"Renato@school.com", password:"123456", admin: false)
User.create!(email:"Felipe@school.com", password:"123456", admin: false)
User.create!(email:"Folkert@school.com", password:"123456", admin: false)
User.create!(email:"FakerBot@school.com", password:"123456", admin: false)
User.create!(email:"FactoryBot@school.com", password:"123456", admin: false)


puts "Creating Matches ..."
# Create matches for 4 days
new_date1 = -48.hours.from_now.to_date
new_date2 = -24.hours.from_now.to_date
new_date3 = 0.hours.from_now.to_date
new_date4 = 24.hours.from_now.to_date

match = Match.new
match.create_matches(new_date1)
match.create_matches(new_date2)
match.create_matches(new_date3)
match.create_matches(new_date4)
