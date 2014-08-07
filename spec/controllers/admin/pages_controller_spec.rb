require 'rails_helper'

describe Admin::PagesController, type: :controller do
  describe 'main' do
    let(:admin) { FactoryGirl.create(:admin)}

    describe 'main for signed admin' do
      before { admin_login admin }

      it 'should render main template when admin signed' do
        get :main
        expect(response).to render_template('main')
      end
    end
    
    describe 'main for non-signed admin' do
      it_should_check_admin_for_actions :main
    end
    
  end
end
