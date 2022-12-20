class UsersController < ApplicationController # GET /users
  def index
    @users = User.all

    render json: {
      data: @users
    }
  end
end
