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
User.create!(email:"Anissa@school.com", password:"123456", admin: false)
User.create!(email:"Renato@school.com", password:"123456", admin: false)
User.create!(email:"Felipe@school.com", password:"123456", admin: false)
User.create!(email:"Folkert@school.com", password:"123456", admin: false)
User.create!(email:"FakerBot@school.com", password:"123456", admin: false)


# Create matches for xx days
days = 100
print "Creating Matches for the last #{days} days ... "
match = Match.new
(-days..-1).each do |d|
  new_date = Date.today + d
  if !(new_date.sunday? || new_date.saturday?)
    print "+"
    match.create_matches(new_date)
  end
end
