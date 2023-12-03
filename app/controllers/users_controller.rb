# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def current_user_info
    render json: current_user, except: %i[created_at updated_at jti]
  end
end
