require 'spec_helper'

describe StaticPagesController do
  describe 'home' do
    it 'should render home template' do
      get 'home'
      response.should render_template('home')
    end
  end

  describe 'top 5 hotels' do
    it 'should render top template' do
      get 'top'
      response.should render_template('top')
    end
  end
end
