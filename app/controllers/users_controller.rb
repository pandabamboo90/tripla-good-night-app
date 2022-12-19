class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :set_user_by_user_id, only: %i[follow unfollow view_follower_sleep_records]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users/:user_id/follow
  def follow
    following_user = @user.follow_user!(follower_id: params[:follower_id])

    render json: {
      message: "You are now following #{following_user.name}"
    }
  end

  # DELETE /users/:user_id/unfollow
  def unfollow
    unfollowed_user = @user.unfollow_user!(follower_id: params[:follower_id])

    render json: {
      message: "You have unfollowed #{unfollowed_user.name}"
    }
  end

  # GET /users/:user_id/view_follower_sleep_records
  def view_follower_sleep_records
    sleep_records = @user.view_follower_sleep_records(follower_id: params[:follower_id])

    render json: {
      data: sleep_records
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_user_by_user_id
    @user = User.find(params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end
end
