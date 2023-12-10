# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include ApiHelper

  describe 'GET #current_user_info' do
    before { @user = create :user }

    context 'when user is authenticated' do
      before(:each) { authenticated_header(request, @user) }

      it 'returns http success' do
        get :current_user_info
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct user' do
        get :current_user_info
        expect(JSON.parse(response.body)['id']).to eq(@user.id)
      end
    end

    context 'when user is not authenticated' do
      it 'returns http unauthorized' do
        get :current_user_info
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
