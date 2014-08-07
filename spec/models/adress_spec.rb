require 'rails_helper'

describe Adress, type: :model do
  before do
    @hotel = FactoryGirl.create(:hotel)
  end
  subject {@hotel.adress}

  it { should respond_to(:country) }
  it { should respond_to(:state) }
  it { should respond_to(:city) }
  it { should respond_to(:street) }
  it { should respond_to(:hotel) }

  describe "when country is not present" do
    before { @hotel.adress.country = " " }
    it { should_not be_valid }
  end
  describe "when city is not present" do
    before { @hotel.adress.city = " " }
    it { should_not be_valid }
  end
  describe "when street is not present" do
    before { @hotel.adress.street = " " }
    it { should_not be_valid }
  end
  describe "when country is too long" do
    before { @hotel.adress.country = "a"*201 }
    it { should_not be_valid }
  end
  describe "when state is too long" do
    before { @hotel.adress.state = "a"*201 }
    it { should_not be_valid }
  end
  describe "when city is too long" do
    before { @hotel.adress.city = "a"*201 }
    it { should_not be_valid }
  end
  describe "when street is too long" do
    before { @hotel.adress.street = "a"*201 }
    it { should_not be_valid }
  end
end
