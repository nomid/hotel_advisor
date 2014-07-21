require 'spec_helper'

describe Hotel do
	before do
	 	@hotel = Hotel.new(title: "Example title", room_desc: "room description",
                     star_rating: 5, breackfest: true, price: 234, user_id:1)
    @hotel.adress = FactoryGirl.create(:adress)
  	end

  	subject {@hotel}

  	it { should respond_to(:title) }
  	it { should respond_to(:star_rating) }
  	it { should respond_to(:breackfest) }
  	it { should respond_to(:room_desc) }
  	it { should respond_to(:photo) }
  	it { should respond_to(:price) }
  	it { should respond_to(:adress) }
  	it { should respond_to(:user) }
  	it { should respond_to(:comments) }

  	it { should be_valid }

  	describe "when title is not present" do
	    before { @hotel.title = " " }
	    it { should_not be_valid }
  	end
  	describe "when room_desc is not present" do
	    before { @hotel.room_desc = " " }
	    it { should_not be_valid }
  	end
  	describe "when price is not present" do
      before { @hotel.price = " " }
      it { should_not be_valid }
    end
    describe "when price is less then 0" do
      before { @hotel.price = -10 }
      it { should_not be_valid }
    end
  	describe "when star_rating is not present" do
	    before { @hotel.room_desc = " " }
	    it { should_not be_valid }
  	end
  	describe "when room_desc is too long" do
	    before { @hotel.room_desc = "a" * 201 }
	    it { should_not be_valid }
  	end
  	describe "when star rating is not inclusion in 1..5" do
	    before { @hotel.star_rating = 6 }
	    it { should_not be_valid }
  	end
  	describe "when star rating is inclusion in 1..5" do
	    before { @hotel.star_rating = 3 }
	    it { should be_valid }
  	end
  	describe "when title is already taken" do
	    before do
			hotel_with_same_title = @hotel.dup
			hotel_with_same_title.title = @hotel.title.upcase
			hotel_with_same_title.save
	    end

	    it { should_not be_valid }
  end
end
