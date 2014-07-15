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
        35.times { FactoryGirl.create(:hotel) } 
        35.times { FactoryGirl.create(:user) } 
      end
      after(:all) do
        Hotel.delete_all 
        User.delete_all
      end 

      describe 'Random comments' do
        before { 35.times { FactoryGirl.create(:comment) } }
        after { Comment.delete_all }
        it { should_not have_selector('div.pagination') }
        it "should list less 6 hotels" do
          expect(page).to have_css('table.hotel', maximum: 5, minimum: 1)
        end
      end

      describe 'Have not comments' do
        before {visit top_path}
        it 'should display text No rated hotels' do
          expect(page).to have_text('No rated hotels')
        end
      end 

      describe 'boundary ratings' do
        let(:hotel_1) { FactoryGirl.create(:hotel) }
        let(:hotel_2) { FactoryGirl.create(:hotel) }
        before do
          7.times { FactoryGirl.create(:user)}
          3.times { FactoryGirl.create(:comment, hotel_id: hotel_1.id, rate: 3) }
          4.times { FactoryGirl.create(:comment, hotel_id: hotel_2.id, rate: 3) }
          visit top_path
        end
        after { Comment.delete_all }

        it 'hotel with id 2 should be higher then hotel with id 1' do
          #expect(page).should have_selector("div.top_hotels:first-child")
          #expect(page).should have_selector(".hotel_title a", text: hotel_2.title)
          #expect(page).should have_selector("div.top_hotels:nth-child(2) .hotel_title a", text: hotel_1.title)
          #expect(page).should_not have_text('No rated hotels')
        end
      end
    end
  end 
end 
