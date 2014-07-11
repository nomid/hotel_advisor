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
  		rating (Random.rand(499) +1).to_f / 100
  		star_rating 5
  	end
end