require 'spec_helper'
include StaticPagesHelper
describe "StaticPages" do
  subject {page}

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
      login user
    end
    it { should_not have_link("Sign in", href: new_user_session_path) }
    it { should_not have_link("Sign up", href: new_user_registration_path) }
  end

  describe "Pages" do
    before(:all) { 35.times { FactoryGirl.create(:hotel) } }
        after(:all)  { Hotel.delete_all }

    describe "Home Page" do
      before do
        visit root_path
      end

      describe "should list of hotels" do

            it { should have_selector('div.pagination') }

            it "should list each hotel" do
              Hotel.paginate(page: 1).order(:title).each do |hotel|
                  expect(page).to have_selector('table .hotel_title a', text: hotel.title)
              end
            end
        end
    end

    describe "Top 5 page" do
      before do 
        visit top_path
      end

      it { should_not have_selector('div.pagination') }
      it "should list less 6 hotels" do
        expect(page).to have_css('table.hotel', maximum: 5, minimum: 0)
      end
      it "should be in right order" do
        ids = get_top_5_ids
          hotels = Hotel.find(ids).index_by(&:id).slice(*ids).values
        hotels.each do |hotel|
                expect(page).to have_selector('table .hotel_title a', text: hotel.title)
            end
      end
    end
  end 
end 
