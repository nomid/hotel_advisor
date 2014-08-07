require 'rails_helper'

describe Admin::UsersController, type: :controller do
  describe 'for non-signed admin' do
    it_should_check_admin_for_actions :index, :destroy, :new, :create, 
                                      :edit, :update
  end

  describe 'for signed admin' do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:user) { FactoryGirl.create(:user) }
    before { admin_login admin }

    describe 'index' do
      it 'should render index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe 'destroy' do
      it 'should redirect to admin_users_path and show notice message' do
        delete :destroy, id: user.id
        expect(response).to redirect_to(admin_users_path)
        expect(flash[:notice]).not_to be_nil
      end
    end

    describe 'new' do
      it 'should render new template' do
        get :new
        expect(response).to render_template('new')
      end
    end

    describe 'create' do
      describe 'with valid information' do
        it 'should redirect to admin_users_path and show success message' do
          post :create, {user: {username: 'username', email: 'email@email.ru', 
                              password: '111111111'}}
          expect(response).to redirect_to(admin_users_path)
          expect(flash[:success]).not_to be_nil
        end
      end

      describe 'with invalid information' do
        it 'should render new template and show alert message' do
          post :create, {user: {username: user.username,  email: user.email, 
                              password: '111111111'}}
          expect(response).to render_template('new')
          expect(flash[:alert]).not_to be_nil                              
        end
      end
    end

    describe 'edit' do
      it 'should render edit template' do
        get :edit, id: user.id
        expect(response).to render_template('edit')
      end
    end

    describe 'update' do
      describe 'with valid information' do
        it 'should redirect to admin_users_path and show success message' do
          post :update, {id: user.id, user: {username: 'username', email: 'email@email.ru', 
                              password: '111111111'}}
          expect(response).to redirect_to(admin_users_path)
          expect(flash[:success]).not_to be_nil
        end
      end

      describe 'with invalid information' do
        it 'should render new template and show alert message' do
          post :update, {id: user.id, user: {username: user.username,  email: user.email, 
                              password: '11'}}
          expect(response).to render_template('new')
          expect(flash[:alert]).not_to be_nil                              
        end
      end
    end

  end
end
