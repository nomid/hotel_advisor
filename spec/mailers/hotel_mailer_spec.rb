require "rails_helper"

RSpec.describe HotelMailer, :type => :mailer do
  describe "reject_hotel" do
    let(:user) {FactoryGirl.create(:user)}
    let(:hotel) { FactoryGirl.create(:hotel, user_id: user.id) }
    let(:mail) { HotelMailer.reject_hotel(hotel) }

    it "send user reject hotel text" do
      mail.subject.should eq("hotel rejected")
      mail.to.should eq([hotel.user.email])
      mail.from.should eq(["from@example.com"])
      mail.body.encoded.should match('You hotel rejected')
    end
  end

  describe "approve_hotel" do
    let(:user) {FactoryGirl.create(:user)}
    let(:hotel) { FactoryGirl.create(:hotel, user_id: user.id) }
    let(:mail) { HotelMailer.approve_hotel (hotel) }

    it "send user approve hotel text" do
      mail.subject.should eq("hotel approved")
      mail.to.should eq([hotel.user.email])
      mail.from.should eq(["from@example.com"])
      mail.body.encoded.should match('You hotel approved')
    end
  end
end
