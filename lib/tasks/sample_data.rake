namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Hotel.create!(title: "Example Hotel",
                 rating: 5,
                 breackfest: true,
                 room_desc: "Example desc",
                 photo: "photo",
                 price: 100,
                 adress: "Example adress")
    99.times do |n|
      title = "Example Hotel #{n+1}"
      rating = Random.rand(5)
      breackfest = true
      room_desc = "Example desc #{n+1}"
      photo = "photo#{n+1}"
      price = 100+n
      adress = "Example adress#{n+1}"
      Hotel.create!(title: title,
                 rating: rating,
                 breackfest: breackfest,
                 room_desc: room_desc,
                 photo: photo,
                 price: price,
                 adress: adress)
    end
  end
end