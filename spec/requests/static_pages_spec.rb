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
    before { 35.times { FactoryGirl.create(:hotel) } }
    after  { Hotel.delete_all }

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
      after(:all) do
        Hotel.delete_all 
        User.delete_all
        Comment.delete_all
      end 

      describe 'Random comments' do
        before do 
          35.times { FactoryGirl.create(:hotel) } 
          35.times { FactoryGirl.create(:user) } 
          35.times { FactoryGirl.create(:comment) } 
          visit top_path
        end  
        it { should_not have_selector('div.pagination') }
        it "should list less 6 hotels" do
          expect(page).to have_css('table.hotel', maximum: 5, minimum: 1)
        end
      end

      describe 'Have not comments' do
        before do
          35.times { FactoryGirl.create(:user) } 
          35.times { FactoryGirl.create(:hotel) }
          visit top_path
        end 
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

        it 'hotel_2 should be higher then hotel_1' do
          page.body.should =~ /#{hotel_2.title}(\S|\s)*#{hotel_1.title}/
        end
      end

      describe 'simple ratings' do
        let(:hotel_1) { FactoryGirl.create(:hotel) }
        let(:hotel_2) { FactoryGirl.create(:hotel) }
        let(:hotel_3) { FactoryGirl.create(:hotel) }
        let(:hotel_4) { FactoryGirl.create(:hotel) }
        let(:hotel_5) { FactoryGirl.create(:hotel) }
        let(:hotel_6) { FactoryGirl.create(:hotel) }
        before do
          10.times { FactoryGirl.create(:user)}
          FactoryGirl.create(:comment, hotel_id: hotel_1.id, rate: 1)
          FactoryGirl.create(:comment, hotel_id: hotel_1.id, rate: 2)
          FactoryGirl.create(:comment, hotel_id: hotel_2.id, rate: 2)
          FactoryGirl.create(:comment, hotel_id: hotel_2.id, rate: 3)
          FactoryGirl.create(:comment, hotel_id: hotel_3.id, rate: 3)
          FactoryGirl.create(:comment, hotel_id: hotel_3.id, rate: 4)
          FactoryGirl.create(:comment, hotel_id: hotel_4.id, rate: 4)
          FactoryGirl.create(:comment, hotel_id: hotel_4.id, rate: 5)
          FactoryGirl.create(:comment, hotel_id: hotel_5.id, rate: 5)
          FactoryGirl.create(:comment, hotel_id: hotel_5.id, rate: 5)
          visit top_path
        end
        it 'should be in right order' do
          page.body.should =~ /#{hotel_5.title}(\S|\s)*#{hotel_4.title}(\S|\s)*#{hotel_3.title}(\S|\s)*#{hotel_2.title}(\S|\s)*#{hotel_1.title}/
        end
      end
    end
  end 
end 
