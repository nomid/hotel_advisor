require 'rails_helper'

describe Admin::SessionsController, type: :controller do
  let(:admin) { FactoryGirl.create(:admin) }
  describe 'new' do
    describe 'for signed admin' do
      before {admin_login admin}
      it 'should redirect to admin_main_path' do
        get :new
        expect(response).to redirect_to(admin_main_path)
      end
    end
    describe 'for non-signed admin' do
      it 'should render new template' do
        get :new
        expect(response).to render_template('new')
      end
    end
  end

  describe 'create' do
    describe 'with valid information' do
      it 'should redirect to admin_main_path' do
        post :create, {admin: {login: admin.login, password: admin.password}}
        expect(response).to redirect_to(admin_main_path)
      end
    end
    describe 'with invalid information' do
      it 'should render new template and show error message' do
        post :create, {admin: {login: admin.login, password: 'invalid'}}
        expect(response).to render_template('new')
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'destroy' do
    before {admin_login admin}
    it 'should redirect to root_url' do
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end
end
