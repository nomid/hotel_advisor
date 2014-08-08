require 'rails_helper'

describe "AdminPages", type: :request do
  let(:admin) { FactoryGirl.create(:admin) }
  before do
    35.times { FactoryGirl.create(:hotel, user_id: Random.rand(1..10)) }
    35.times { FactoryGirl.create(:user) }
  end

  describe 'login page' do
    before do
      visit admin_root_path
    end
    it { expect(page).to have_text('Login') }
    it { expect(page).to have_text('Password') }
    it { expect(page).to have_selector('input[type=submit]') }

    describe 'login with valid information' do
      before do
        fill_in 'Login', with: admin.login
        fill_in 'Password', with: admin.password
        click_button 'sign in'
      end

      it 'should login' do
        expect(current_path).to eq(admin_main_path)
      end
    end

    describe 'login with invalid information' do
      before do
        fill_in 'Login', with: admin.login
        fill_in 'Password', with: 'invalid'
        click_button 'sign in'
      end

      it 'should not login and show error message' do
        expect(current_path).to eq(admin_root_path)
        expect(page).to have_text('Invalid email/password combination')
      end
    end
  end

  describe 'main page' do
    before do
      admin_login admin
    end

    it { expect(page).to have_link('Users management', href: admin_users_path) }
    it { expect(page).to have_link('Hotels management', href: admin_hotels_path) }
  end

  describe 'users management pages' do
    before do
      admin_login admin
      visit admin_users_path
    end

    describe 'users management page' do
      it {expect(page).to have_selector('#users_table')}
      it {expect(page).to have_selector('div.pagination')}
      it {expect(page).to have_text('filter by name')}
      it {expect(page).to have_text('filter by email')}
      it {expect(page).to have_link('Add user', href: new_admin_user_path)}
      it {expect(page).to have_link('username', href: admin_users_path(sort_by: "username_asc"))}
      it {expect(page).to have_link('email', href: admin_users_path(sort_by: "email_asc"))}
      it {expect(page).to have_link('hotels', href: admin_users_path(sort_by: "hotels_asc"))}
      it {expect(page).to have_link('comments', href: admin_users_path(sort_by: "comments_asc"))}
      it 'should list of users' do 
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('#users_table tr td', text: user.id)
          expect(page).to have_selector('#users_table tr td', text: user.username)
          expect(page).to have_selector('#users_table tr td', text: user.email)
          expect(page).to have_selector('#users_table tr td', text: user.hotels.count)
          expect(page).to have_selector('#users_table tr td', text: user.comments.count)
        end
      end

      describe 'sort by username asc' do
        before do
          click_link 'username'
        end

        it {expect(page).to have_link('username', href: admin_users_path(sort_by: "username_desc"))}
        it 'should sort by username asc' do
          users = User.username_asc.paginate(page: 1)
          users.each do |user|
            expect(page).to have_selector('#users_table tr td', text: user.username)
          end
        end

        describe 'sort by username desc' do
          before do
            click_link 'username'
          end

          it {expect(page).to have_link('username', href: admin_users_path(sort_by: "username_asc"))}
          it 'should sort by username desc' do
            users = User.username_desc.paginate(page: 1)
            users.each do |user|
              expect(page).to have_selector('#users_table tr td', text: user.username)
            end
          end
        end
      end

      describe 'sort by email asc' do
        before do
          click_link 'email'
        end

        it {expect(page).to have_link('email', href: admin_users_path(sort_by: "email_desc"))}
        it 'should sort by email asc' do
          users = User.email_asc.paginate(page: 1)
          users.each do |user|
            expect(page).to have_selector('#users_table tr td', text: user.username)
          end
        end

        describe 'sort by email desc' do
          before do
            click_link 'email'
          end

          it {expect(page).to have_link('email', href: admin_users_path(sort_by: "email_asc"))}
          it 'should sort by email desc' do
            users = User.email_desc.paginate(page: 1)
            users.each do |user|
              expect(page).to have_selector('#users_table tr td', text: user.username)
            end
          end
        end
      end

      describe 'sort by hotels asc' do
        before do
          click_link 'hotels'
        end

        it {expect(page).to have_link('hotels', href: admin_users_path(sort_by: "hotels_desc"))}
        it 'should sort by hotels asc' do
          users = User.hotels_asc.paginate(page: 1)
          users.each do |user|
            expect(page).to have_selector('#users_table tr td', text: user.username)
          end
        end

        describe 'sort by hotels desc' do
          before do
            click_link 'hotels'
          end

          it {expect(page).to have_link('hotels', href: admin_users_path(sort_by: "hotels_asc"))}
          it 'should sort by hotels desc' do
            users = User.hotels_desc.paginate(page: 1)
            users.each do |user|
              expect(page).to have_selector('#users_table tr td', text: user.username)
            end
          end
        end
      end

      describe 'sort by comments asc' do
        before do
          click_link 'comments'
        end

        it {expect(page).to have_link('comments', href: admin_users_path(sort_by: "comments_desc"))}
        it 'should sort by comments asc' do
          users = User.comments_asc.paginate(page: 1)
          users.each do |user|
            expect(page).to have_selector('#users_table tr td', text: user.username)
          end
        end

        describe 'sort by comments desc' do
          before do
            click_link 'comments'
          end

          it {expect(page).to have_link('comments', href: admin_users_path(sort_by: "comments_asc"))}
          it 'should sort by comments desc' do
            users = User.comments_desc.paginate(page: 1)
            users.each do |user|
              expect(page).to have_selector('#users_table tr td', text: user.username)
            end
          end
        end
      end

      describe 'filter by username with valid filter' do
        before do
          visit "#{admin_users_path}?filter_by_name=e"
        end
        it 'should filter by username' do
          users = []
          User.all.each do |user|
            users << user if (user.username.downcase.include?('e'))
          end
          users.paginate(page: 1).each do |user|
            expect(page).to have_selector('#users_table tr td', text: user.username)
          end
        end
      end

      describe 'filter by username with invalid filter' do
        before do
          visit "#{admin_users_path}?filter_by_name=eqwerfasdf"
        end
        it {expect(page).to have_text('No users find')}
      end

      describe 'filter by email with valid filter' do
        before do
          visit "#{admin_users_path}?filter_by_email=e"
        end
        it 'should filter by email' do
          users = []
          User.all.each do |user|
            users << user if (user.email.downcase.include?('e'))
          end
          users.paginate(page: 1).each do |user|
            expect(page).to have_selector('#users_table tr td', text: user.username)
          end
        end
      end

      describe 'filter by email with invalid filter' do
        before do
          visit "#{admin_users_path}?filter_by_email=eqwerfasdf"
        end
        it {expect(page).to have_text('No users find')}
      end

    end

    describe 'create new user page' do
      before do
        click_link 'Add user'
      end

      it {expect(page).to have_text('Username')}
      it {expect(page).to have_text('Email')}
      it {expect(page).to have_text('Password')}
      it {expect(page).to have_selector('input[type=submit]')}

      describe 'create user with valid information' do
        before do
          admin_user_form(valid: true)
        end

        it 'should create user' do
          expect { click_button "Create User" }.to change(User, :count).by(1)
        end
      end

      describe 'create user with invalid information' do
        before do
          admin_user_form(valid: false)
        end

        it 'should create user' do
          expect { click_button "Create User" }.to change(User, :count).by(0)
        end
      end
    end

    describe 'edit user page' do
      before do
        click_link User.first.username
      end

      it {expect(current_path).to eq(edit_admin_user_path(User.first))}

      describe 'edit user with valid information' do
        before do
          admin_user_form(valid: true)
          click_button 'Update User'
        end
        it { expect(User.first.username).to eq('new_user_username') }
      end

      describe 'edit user with invalid information' do
        before do
          admin_user_form(valid: false)
          click_button 'Update User'
        end

        it { expect(User.first.username).not_to eq('new_user_username') }
      end
    end

    describe 'delete link' do
      before do
        
      end
      it 'should delete user' do
        expect {first('#users_table tr').click_link('delete')}.to change(User, :count).by(-1)
      end
    end

  end

  describe 'hotels management page' do
    before do
      admin_login admin
      visit admin_hotels_path
    end
    let(:hotel) { Hotel.first }
    it { expect(page).to have_link('approve', href: admin_hotel_path(hotel, new_status: 'a'))}
    it { expect(page).to have_link('reject', href: admin_hotel_path(hotel, new_status: 'r'))}
    it { expect(page).to have_selector('#hotels_table')}
    it { expect(page).to have_selector('#filter_by_status')}
    it 'should list of hotels' do 
      Hotel.paginate(page: 1).each do |hotel|
        expect(page).to have_selector('#hotels_table tr td', text: hotel.id)
        expect(page).to have_selector('#hotels_table tr td', text: hotel.title)
        expect(page).to have_selector('#hotels_table tr td', text: hotel.user.username)
        expect(page).to have_selector('#hotels_table tr td', text: hotel.comments.count)
        expect(page).to have_selector('#hotels_table tr td', text: hotel.status)
      end
    end

    describe 'filter by status - pending' do
      before do
        visit "#{admin_hotels_path}?filter_by_status=p"
      end

      it 'should list hotels with pending status' do
        Hotel.where(status: 'p').paginate(page: 1).each do |hotel|
          expect(page).to have_selector('#hotels_table tr td', text: hotel.title)
        end
      end
    end 

    describe 'filter by status - approved when none' do
      before do
        visit "#{admin_hotels_path}?filter_by_status=a"
      end
      it { expect(page).to have_text('no hotels find') }
    end 
    
    describe 'filter by status - approved' do
      before do
        FactoryGirl.create(:hotel, status: 'a')
        visit "#{admin_hotels_path}?filter_by_status=a"
      end

      it 'should list hotels with approved status' do
        Hotel.where(status: 'a').paginate(page: 1).each do |hotel|
          expect(page).to have_selector('#hotels_table tr td', text: hotel.title)
        end
      end
    end 

    describe 'filter by status - rejected' do
      before do
        FactoryGirl.create(:hotel, status: 'r')
        visit "#{admin_hotels_path}?filter_by_status=r"
      end

      it 'should list hotels with rejected status' do
        Hotel.where(status: 'r').paginate(page: 1).each do |hotel|
          expect(page).to have_selector('#hotels_table tr td', text: hotel.title)
        end
      end
    end 

    describe 'approve hotel' do
      before do
        first('#hotels_table tr').click_link('approve')
      end
      it { expect(Hotel.first.status).to eq('a') }
    end

    describe 'reject hotel' do
      before do
        first('#hotels_table tr').click_link('reject')
      end
      it { expect(Hotel.first.status).to eq('r') }
    end
  end
end
