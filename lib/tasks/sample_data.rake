namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    make_users
    make_hotels
    make_comments
  end
end

def make_comments
  count = 0
  5.times do |u|
    rated_hotels = Array.new
    3.times do |n|
      #begin
        hotel_id = u+1#Random.rand(1..100)
      #end while rated_hotels.include? hotel_id
      rated_hotels.push hotel_id
      user_id = u+1
      comment = "Example comment #{count}"
      rate = Random.rand(1..u+1)
      Comment.create!(hotel_id: hotel_id,
                      user_id: user_id,
                      comment: comment,
                      rate: rate)
      count += 1
    end
  end
end

def make_users
  admin = User.create!(username:     "Example User",
                       email:    "login@login.ru",
                       password: "11111111",
                       password_confirmation: "11111111")
  49.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password111"
    User.create!(username:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_hotels
  #Hotel.create!(title: "Example Hotel",
  #               star_rating: 5,
  #               breackfest: true,
  #               room_desc: "Example desc",
  #               photo: "photo",
  #               price: 100,
  #               user_id: 1)
  
    100.times do |n|
      title = "Example Hotel #{n+1}"
      star_rating = Random.rand(1..5)
      breackfest = true
      room_desc = "Example desc #{n+1}"
      photo = "photo#{n+1}"
      price = 100+n
      adress = "Example adress#{n+1}"
      user_id = Random.rand(1..50)
      hotel = Hotel.create!(title: title,
                 star_rating: star_rating,
                 breackfest: breackfest,
                 room_desc: room_desc,
                 photo: photo,
                 price: price,
                 user_id: user_id)
      hotel.adress = Adress.create!(country: "Ukraine",
                  state: "example state",
                  city: "example city",
                  street: "example street")
    end
end