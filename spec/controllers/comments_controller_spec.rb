require 'spec_helper'

describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:hotel) { FactoryGirl.create(:hotel) }
  before { sign_in user }

  it 'should redirect to rated hotel on successful rate' do
  	post 'create', {comment: {user_id: user.id, hotel_id: hotel.id, rate: 5,
                        comment: 'example comment'} }
  	flash[:success].should_not be_nil
  	response.should redirect_to(hotel)
  end
  it 'should be alert on failed rate' do
  	post 'create', {comment: {user_id: user.id, hotel_id: hotel.id, rate: 5} }
  	flash[:alert].should_not be_nil
  	response.should redirect_to(hotel)
  end
end
