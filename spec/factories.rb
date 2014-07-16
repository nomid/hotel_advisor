FactoryGirl.define do
  	factory :user do
	    sequence(:username)  { |n| "Person #{n}" }
	    sequence(:email) { |n| "person_#{n}@example.com"}
	    password "foobar111"
	    password_confirmation "foobar111"
  	end

  	factory :hotel do
  		sequence(:title)  { |n| "Hotel #{n}" }
  		breackfest true
  		room_desc "Room description"
  		photo "Some photo"
  		price 100.00
  		adress "Adress"
  		star_rating 5
      sequence(:user_id) { |n| n }
  	end

    factory :comment do
      sequence(:hotel_id) { |n| n }
      sequence(:user_id) { |n| n }
      rate Random.rand(1..5)
      comment "example comment"
    end
end