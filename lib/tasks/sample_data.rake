namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    make_users
    make_hotels
    make_comments
  end
end

def make_comments
  comment = Comment.create!(hotel_id: 1,
                            user_id: 1,
                            comment: "example comment",
                            rate: 5)
  99.times do |n|
    hotel_id = Random.rand(99) + 1
    user_id = Random.rand(99) + 1
    comment = "Example comment #{n+1}"
    rate = Random.rand(4) + 1
    Comment.create!(hotel_id: hotel_id,
                    user_id: user_id,
                    comment: comment,
                    rate: rate)
  end
end

def make_users
  admin = User.create!(username:     "Example User",
                       email:    "login@login.ru",
                       password: "11111111",
                       password_confirmation: "11111111")
  99.times do |n|
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
  Hotel.create!(title: "Example Hotel",
                 star_rating: 5,
                 breackfest: true,
                 room_desc: "Example desc",
                 photo: "photo",
                 price: 100,
                 adress: "Example adress",
                 user_id: 1)
    99.times do |n|
      title = "Example Hotel #{n+1}"
      star_rating = Random.rand(4)+1
      breackfest = true
      room_desc = "Example desc #{n+1}"
      photo = "photo#{n+1}"
      price = 100+n
      adress = "Example adress#{n+1}"
      user_id = Random.rand(99) + 1
      Hotel.create!(title: title,
                 star_rating: star_rating,
                 breackfest: breackfest,
                 room_desc: room_desc,
                 photo: photo,
                 price: price,
                 adress: adress,
                 user_id: user_id)
    end
end