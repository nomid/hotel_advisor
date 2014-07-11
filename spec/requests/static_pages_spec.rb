require 'spec_helper'

describe "StaticPages" do
	subject {page}

	describe "Home Page" do

		before do
			visit root_path
		end

		describe "For non signed users" do
			it { should have_link("Sign in", href: new_user_session_path) }
			it { should have_link("Sign up", href: new_user_registration_path) }
		end

		describe "For signed users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				sign_in user
			end
			it { should_not have_link("Sign in", href: new_user_session_path) }
			it { should_not have_link("Sign up", href: new_user_registration_path) }
		end

		describe "should list of hotels" do

	      	before(:all) { 35.times { FactoryGirl.create(:hotel) } }
	      	after(:all)  { Hotel.delete_all }

	      	it { should have_selector('div.pagination') }

	      	it "should list each hotel" do
		        Hotel.paginate(page: 1).each do |hotel|
		          	expect(page).to have_selector('table .hotel_title', text: hotel.title)
		        end
	      	end
	    end
	end

	describe "Top 5 page" do
		before do 
			visit top_path
			35.times { FactoryGirl.create(:hotel) }
		end
		after  { Hotel.delete_all }

		it { should_not have_selector('div.pagination') }
		it "should list 5 hotels" do
			expect(page).to have_css('table.hotel', maximum: 5)
		end
		#it "should be in right order" do
		#	hotels = Hotel.order('rating DESC').limit(5)
		#	first = page.first('.hotel_title a').text
		#	it { hotels.first.title.to eq first }
		#end
	end
end	
