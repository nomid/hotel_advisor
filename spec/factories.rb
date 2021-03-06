FactoryGirl.define do
  	factory :user do
      sequence(:username)  { |n| "Person #{n}" }
      sequence(:email) { |n| "person_#{n}@example.com"}
      password "foobar111"
      password_confirmation "foobar111"
    end

    factory :admin do
      login "admin"
      password "111111"
      password_confirmation "111111"
    end

  	factory :hotel do
  		sequence(:title)  { |n| "Hotel #{n}" }
  		breackfest true
  		room_desc "Room description"
  		photo "Some photo"
  		price 100.00
  		star_rating 5
      sequence(:user_id) { |n| n }
      adress {|n| n.association(:adress)}
  	end
    factory :adress do
      country "example country"
      state "example state"
      city "example city"
      street "example street"
    end
    factory :comment do
      sequence(:hotel_id) { |n| n }
      sequence(:user_id) { |n| n }
      rate Random.rand(1..5)
      comment "example comment"
    end
end