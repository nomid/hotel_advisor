require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  it 'should render show template' do
    get 'show'
    expect(response).to render_template('show')
  end
end
