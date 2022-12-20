class MeController < ApplicationController

  # GET /me/sleep_records
  def sleep_records
    sleep_records = @current_user.sleep_records
                                 .order(:created_at, :desc)

    render json: {
      data: sleep_records
    }
  end

  # POST me/sleep_records
  def add_sleep_record
    sleep_record = @current_user.add_sleep_record!(sleep_record_params: sleep_record_params)

    render json: {
      data: sleep_record
    }
  end

  # PUT me/sleep_records/:id
  def update_sleep_record
    sleep_record = @current_user.update_sleep_record!(sleep_record_id: params[:id],
                                                      sleep_record_params: sleep_record_params)
    render json: {
      data: sleep_record
    }
  end

  # GET /me/followers
  def followers
    followers = @current_user.followers.select(:id, :name, :created_at)

    render json: {
      data: followers
    }
  end

  # GET /me/following_users
  def following_users
    following_users = @current_user.following_users.select(:id, :name, :created_at)

    render json: {
      data: following_users
    }
  end

  # PUT /me/follow/:user_id
  def follow
    following_user = @current_user.follow_user!(user_id: params[:user_id])

    render json: {
      message: "You are now following #{following_user.name}"
    }
  end

  # PUT /me/unfollow/:user_id
  def unfollow
    unfollowed_user = @current_user.unfollow_user!(user_id: params[:user_id])

    render json: {
      message: "You have unfollowed #{unfollowed_user.name}"
    }
  end

  # GET /me/followers/:user_id/sleep_records
  def view_follower_sleep_records
    follower_sleep_records = @current_user.view_follower_sleep_records(user_id: params[:user_id])

    render json: {
      data: follower_sleep_records
    }
  end

  private

  def sleep_record_params
    params.require(:sleep_record).permit(:started_at, :ended_at)
  end
end
