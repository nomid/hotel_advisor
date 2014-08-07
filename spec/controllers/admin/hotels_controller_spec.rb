require 'rails_helper'

describe Admin::HotelsController, type: :controller do

  describe 'for non-signed admin' do
    it_should_check_admin_for_actions :index, :update
  end

  describe 'for signed admin' do
    let(:admin) { FactoryGirl.create(:admin) }
    before { admin_login admin }

    describe 'index' do
      it 'should render index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe 'update' do
      let(:user) { FactoryGirl.create(:user)}
      let(:hotel) { FactoryGirl.create(:hotel, user_id: user.id) }
      describe 'approve hotel' do
        it 'should redirect to admin_hotels_path and show success message' do
          patch :update, {id: hotel.id, new_status: 'a'}
          expect(response).to redirect_to(admin_hotels_path)
          expect(flash[:success]).to eq('hotel approved')
          expect(last_email.to).to include(user.email)
        end
      end
      describe 'reject hotel' do
        it 'should redirect to admin_hotels_path and show success message' do
          patch :update, {id: hotel.id, new_status: 'r'}
          expect(response).to redirect_to(admin_hotels_path)
          expect(flash[:success]).to eq('hotel rejected')
          expect(last_email.to).to include(user.email)
        end
      end
    end
  end

end
