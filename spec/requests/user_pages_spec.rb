require 'rails_helper'

describe "UserPages", type: :request do
  subject {page}
  let(:user) { FactoryGirl.create(:user) }
  before do
    login user
  end

  describe "Profile page" do    
    before do
      visit user_root_path
    end
    it { should have_link("Edit profile", href: edit_user_registration_path) }
    it { expect(page).to have_selector('h1', text: 'My profile') }
    it { expect(page).to have_text(user.username) }
    it { expect(page).to have_text(user.email) }
  end

  describe "Profile edit page" do
    before do
      visit edit_user_registration_path
    end

    it { expect(page).to have_selector('h2', text: 'Edit User') }
    it { expect(page).to have_selector('#user_username') }
    it { expect(page).to have_selector('#user_email') }
    it { expect(page).to have_selector('#user_password') }                                              
    it { expect(page).to have_selector('#user_password_confirmation') }
    it { expect(page).to have_selector('#user_current_password') }
    it { should have_link("Cancel my account") }

    describe "Cancel registration" do
      it { expect { click_link "Cancel my account" }.to change(User, :count).by(-1) }
    end

    describe "Editing profile" do
      describe "with valid information" do
        before do
          fill_in 'user_username', with: "Lorem ipsum"
          fill_in 'user_email', with: "test@test.com"
          fill_in 'user_password', with: "12345678"
          fill_in 'user_password_confirmation', with: "12345678"
          fill_in 'user_current_password', with: "foobar111"
          click_button "Update"
        end

        specify { expect(user.reload.username).to  eq "Lorem ipsum" }
            specify { expect(user.reload.email).to eq "test@test.com" }
      end
      describe "with invalid information" do
        before {click_button "Update"}

        it {expect(page).to have_selector('h2', text: 'Edit User')}
      end
    end
  end
end
