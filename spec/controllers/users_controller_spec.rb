require 'spec_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  it 'should render show template' do
    get 'show'
    response.should render_template('show')
  end
end
