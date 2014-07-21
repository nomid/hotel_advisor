require 'spec_helper'

describe HotelsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:hotel) { FactoryGirl.create(:hotel, user_id: user.id) }
  let(:not_own_hotel) { FactoryGirl.create(:hotel, user_id: user.id+1) }
  describe 'new' do
    it 'should render new template' do
      get 'new'
      response.should render_template('new')
    end
  end

  describe 'show' do
    it 'should render right hotel' do
      get 'show', {format: hotel.id}
      response.should render_template('show')
    end
  end

  describe 'create' do
    before { sign_in user }
    it 'should display success notice and redirect to my hotels on success create' do
      post 'create', {hotel: {title: 'example title', star_rating: 5,
                              breackfest: true, room_desc: 'room description',
                              price: 111, adress_attributes: { country: "country", state: "state",
                              city: "city", street: "street" },
                              user_id: user.id} }
      flash[:success].should_not be_nil
      response.should redirect_to(myhotels_hotel_path)
    end
    it 'should display alert notice and render new template on failed create' do
      post 'create', {hotel: {star_rating: 5,
                              breackfest: true, room_desc: 'room description',
                              price: 111, adress_attributes: { country: "country", state: "state",
                              city: "city", street: "street" },
                              user_id: user.id} }
      flash[:alert].should_not be_nil
      response.should render_template('new')
      #response.should redirect_to(new_hotel_path)
    end
  end

  describe 'myhotels' do
    before { sign_in user }
    it 'should render myhotels template' do
      get 'myhotels'
      response.should render_template('myhotels')
    end
  end

  describe 'edit' do
    before { sign_in user }
    it 'should render editing own hotel' do
      get 'edit', {format: hotel.id}
      response.should render_template('edit')
    end
    it 'should alert notice and redirect to root when try edit not own hotel' do
      get 'edit', {format: not_own_hotel.id}
      flash[:alert].should_not be_nil
      response.should redirect_to(root_path)
    end
  end

  describe 'update' do
    before { sign_in user }
    it 'should display success notice and redirect to my hotels page when information valid' do
      post 'update', {hotel: {title: 'example title', star_rating: 5,
                              breackfest: true, room_desc: 'room description',
                              price: 111, adress_attributes: { country: "country", state: "state",
                              city: "city", street: "street" },
                              user_id: user.id, id: hotel.id} }
      flash[:success].should_not be_nil
      response.should redirect_to(myhotels_hotel_path)
    end
    it 'should display alert notice and render edit template when information invalid' do
      post 'update', {hotel: {title: 'example title', star_rating: 5,
                              breackfest: true, room_desc: 'room description',
                              price: -111, adress_attributes: { country: "country", state: "state",
                              city: "city", street: "street" },
                              user_id: user.id, id: hotel.id} }
      flash[:alert].should_not be_nil
      response.should render_template('edit')
    end
    it 'should display alert notice and redirect to root when edit not own hotel' do
      post 'update', {hotel: {title: 'example title', star_rating: 5,
                              breackfest: true, room_desc: 'room description',
                              price: 111, adress_attributes: { country: "country", state: "state",
                              city: "city", street: "street" },
                              user_id: user.id, id: not_own_hotel.id} }
      flash[:alert].should_not be_nil
      response.should redirect_to(root_path)
    end
  end

  describe 'destroy' do
    before { sign_in user }
    it 'should display success notice and redirect to my hotels page' do
      delete 'destroy', format: hotel.id
      flash[:success].should_not be_nil
      response.should redirect_to(myhotels_hotel_path)
    end
    it 'should display alert notice and redirect to root path when delete not own hotel' do
      delete 'destroy', format: not_own_hotel.id
      flash[:alert].should_not be_nil
      response.should redirect_to(root_path)
    end
  end
end
