class User < ApplicationRecord

  include ::TimeUtils

  # Associations
  has_many :sleep_records
  has_many :user_followers

  # Validations
  validates_presence_of :name

  # ------------------------------------------------
  # Public methods
  # ------------------------------------------------

  def followers
    users_ids = UserFollower.where(following_user_id: self.id, status: :following)
                    .pluck(:user_id)
    User.where(id: users_ids)
  end

  def following_users
    following_users_ids = UserFollower.where(user_id: self.id, status: :following)
                              .pluck(:following_user_id)
    User.where(id: following_users_ids)
  end

  def follow_user!(user_id:)
    raise StandardError.new "You can't follow yourself" if user_id.to_s == self.id.to_s

    user_follower = self.user_followers.find_or_initialize_by(
      following_user_id: user_id
    )
    user_follower.status = :following
    user_follower.save!

    # Return following user
    User.find(user_id)
  end

  def unfollow_user!(user_id:)
    raise StandardError.new "You can't unfollow yourself" if user_id.to_s == self.id.to_s

    user_follower = self.user_followers.find_by(
      following_user_id: user_id
    )

    if user_follower.present?
      user_follower.status = :unfollowed
      user_follower.save!
    else
      raise StandardError.new "You are not following this User"
    end

    # Return unfollowed user
    User.find(user_id)
  end

  def view_follower_sleep_records(user_id:)
    is_following = self.followers.where(id: user_id).present?
    raise StandardError.new "you are not allowed to view sleep records of this Follower because they are not following you" if is_following.blank?

    follower = User.find(user_id)
    sleep_records = follower.sleep_records.order(duration: :desc)
  end

  def add_sleep_record!(sleep_record_params:)
    started_at_as_datetime = Timeliness.parse(sleep_record_params[:started_at], :datetime, strict: true)
    end_at_as_datetime = Timeliness.parse(sleep_record_params[:ended_at], :datetime, strict: true)

    duration = end_at_as_datetime.present? ? end_at_as_datetime - started_at_as_datetime : 0
    duration_as_hms = seconds_to_hms(duration).split(':').map(&:to_i)

    sleep_record = self.sleep_records.create!(
      started_at: started_at_as_datetime,
      ended_at: end_at_as_datetime,
      hours: duration_as_hms[0],
      minutes: duration_as_hms[1],
      seconds: duration_as_hms[2],
      duration: duration
    )

    sleep_record
  end

  def update_sleep_record!(sleep_record_id:, sleep_record_params:)
    sleep_record = self.sleep_records.find_by!(id: sleep_record_id)
    started_at_as_datetime = sleep_record.started_at
    end_at_as_datetime = Timeliness.parse(sleep_record_params[:ended_at], :datetime, strict: true)

    duration = end_at_as_datetime.present? ? (end_at_as_datetime - started_at_as_datetime).to_i : 0
    duration_as_hms = seconds_to_hms(duration).split(':').map(&:to_i)

    sleep_record.update!(
      started_at: started_at_as_datetime,
      ended_at: end_at_as_datetime,
      hours: duration_as_hms[0],
      minutes: duration_as_hms[1],
      seconds: duration_as_hms[2],
      duration: duration
    )

    sleep_record
  end
end
