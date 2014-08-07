require 'rails_helper'

describe Admin, type: :model do
  before do
    @admin = Admin.create(login: 'admin',
              password: '111111',
              password_confirmation: '111111')
  end
  
  it { expect(@admin).to respond_to(:login) }
  it { expect(@admin).to respond_to(:password_digest) }
  it { expect(@admin).to be_valid}
  
  describe "when login is not present" do
    before { @admin.login = " " }
    it { expect(@admin).not_to be_valid }
  end

  describe "when login is too long" do
    before { @admin.login = "a" * 51 }
    it { expect(@admin).not_to be_valid }
  end
  
  describe "when password is not present" do
    before { @admin.password = @admin.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @admin.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @admin.password = @admin.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "when login is already taken" do
    before do
      admin_with_same_login = @admin.dup
      admin_with_same_login.login = @admin.login.upcase
      admin_with_same_login.save
    end

    it { should_not be_valid }
  end
end
