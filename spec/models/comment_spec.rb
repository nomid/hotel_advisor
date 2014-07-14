require 'spec_helper'

describe Comment do
	before do
	 	@comment = Comment.new(user_id: 1, hotel_id: 1,
                     comment: "Example comment", rate: 4)
	end

	subject {@comment}

	it { should respond_to(:comment) }
	it { should respond_to(:rate) }
	it { should respond_to(:comment) }
	it { should respond_to(:user) }

	describe "when comment is not present" do
	    before { @comment.comment = " " }
	    it { should_not be_valid }
  	end
  	describe "when rate is not present" do
	    before { @comment.rate = " " }
	    it { should_not be_valid }
  	end
  	describe "when comment is too long" do
	    before { @comment.comment = "a"*201 }
	    it { should_not be_valid }
  	end
  	describe "when rate is not inclusion in 1..5" do
	    before { @comment.rate = 6 }
	    it { should_not be_valid }
  	end
  	describe "when rate is inclusion in 1..5" do
	    before { @comment.rate = 3 }
	    it { should be_valid }
  	end

end
