require 'rails_helper'

describe "HotelPages", type: :request do
  subject {page}
  let(:hotel) { FactoryGirl.create(:hotel) }
  let(:user) { FactoryGirl.create(:user) }

  describe "Hotel page" do
    before { visit hotel_path(hotel) }

    it { expect(page).to have_selector('h2', text: hotel.title) }
    it { expect(page).to have_text('Photo') }
    it { expect(page).to have_text('Stars') }
    it { expect(page).to have_text('Breackfest') }
    it { expect(page).to have_text('Price for room') }
    it { expect(page).to have_text('Adress') }  
    it { expect(page).to have_text('Room description') }
    
    describe "For non-signed users" do
      it { expect(page).to_not have_selector('div.add_comment')}
    end

    describe "For signed users" do
      before do
        login user
        visit hotel_path(hotel)
      end

      it { expect(page).to have_selector('div.add_comment') }

      describe "If you already rate this hotel" do
        before do
          comment = Comment.create(user_id: user.id, hotel_id: hotel.id, rate: 5,
                        comment: 'example comment')
          visit hotel_path(hotel)
        end
        it { expect(page).to_not have_selector('div.add_comment')}
        it { expect(page).to have_text('You have already rate this hotel')}
      end
    end
  end

  describe "Add hotel" do
    before do
      login user
      visit new_hotel_path
    end

    it { expect(page).to have_selector('h2', text: 'New hotel') }
    it { expect(page).to have_selector('#hotel_title') }
    it { expect(page).to have_selector('#hotel_photo') }
    it { expect(page).to have_selector('#hotel_breackfest') }                                             
    it { expect(page).to have_selector('#hotel_room_desc') }
    it { expect(page).to have_selector('#hotel_price') }
    it { expect(page).to have_selector('#hotel_adress_attributes_country') }
    it { expect(page).to have_selector('#hotel_adress_attributes_state') }
    it { expect(page).to have_selector('#hotel_adress_attributes_city') }
    it { expect(page).to have_selector('#hotel_adress_attributes_street') }
    it { expect(page).to have_selector('#hotel_star_rating_5') }
    it { expect(page).to have_selector('#hotel_star_rating_4') }
    it { expect(page).to have_selector('#hotel_star_rating_3') }
    it { expect(page).to have_selector('#hotel_star_rating_2') }
    it { expect(page).to have_selector('#hotel_star_rating_1') }
    it { expect(page).to have_selector('#hotel_id') }

    describe "Create hotel" do
      describe "with valid information" do
        before do
          fill_in 'hotel_title', with: "Some hotel"
          fill_in 'hotel_room_desc', with: "Example room description"
          fill_in 'hotel_price', with: "123"
          select 'Albania', :from => 'hotel_adress_attributes_country'
          #fill_in 'hotel_adress_attributes_country', with: "Example country"
          fill_in 'hotel_adress_attributes_state', with: "Example state"
          fill_in 'hotel_adress_attributes_city', with: "Example city"
          fill_in 'hotel_adress_attributes_street', with: "Example street"
          choose 'hotel_star_rating_2' 
        end

        it 'should create hotel' do
          expect { click_button "Create Hotel" }.to change(Hotel, :count).by(1)
        end

        describe do
          before { click_button "Create Hotel" }
          it { expect(page).to have_selector('h2', text: 'My hotels') }
          it { expect(page).to have_selector('.alert-success', text: 'Hotel created')}
        end
      end
      
      describe "with invalid information" do
        it 'should not create hotel' do
          expect { click_button "Create Hotel" }.not_to change(Hotel, :count)
        end

        describe do
          before { click_button "Create Hotel" }
          it { expect(page).to have_selector('h2', text: 'New hotel') }
          it { expect(page).to have_selector('.alert-alert', text: 'Fill required fields') }
        end
      end
    end
  end

  describe "My hotels" do
    before do
      login user
      visit myhotels_hotel_path
    end

    it "should contains my hotels" do
      hotels = user.hotels
      hotels.each do |hotel|
          expect(page).to have_selector('table .hotel_title a', text: hotel.title)
          it { should have_link("edit", href: edit_hotel_path(hotel)) }
          it { should have_link("delete", href: hotel) }
      end
    end
  end
end
