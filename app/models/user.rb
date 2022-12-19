class User < ApplicationRecord

  # Associations
  has_many :sleep_records
  has_many :user_followers
  has_many :followers, through: :user_followers, foreign_key: :follower_id, class_name: 'User'
  has_many :following_users, through: :user_followers, foreign_key: :user_id, class_name: 'User'

  # Validations
  validates_presence_of :name

  # ------------------------------------------------
  # Public methods
  # ------------------------------------------------
  def follow_user!(follower_id:)
    raise StandardError.new "You can't follow yourself" if follower_id.to_s == self.id.to_s

    user_follower = self.user_followers.find_or_initialize_by(
      follower_id: follower_id
    )
    user_follower.status ||= :following
    user_follower.save!

    # Return following user
    User.find(follower_id)
  end

  def unfollow_user!(follower_id:)
    raise StandardError.new "You can't unfollow yourself" if follower_id.to_s == self.id.to_s

    user_follower = self.user_followers.find_or_initialize_by(
      follower_id: follower_id
    )
    user_follower.status ||= :unfollowed
    user_follower.save!

    # Return unfollowed user
    User.find(follower_id)
  end

  def view_follower_sleep_records(follower_id:)
    is_following = self.user_followers.where(status: :following, follower_id: follower_id).exists?
    raise StandardError.new "you are not allowed to view sleep records of this Follower because they are not following you" if is_following.blank?

    follower = User.find(follower_id)
    sleep_records = follower.sleep_records.order(duration: 'desc')
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

  def update_sleep_record!(sleep_record:, sleep_record_params:)
    started_at_as_datetime = sleep_record.started_at
    end_at_as_datetime = Timeliness.parse(sleep_record_params[:ended_at], :datetime, strict: true)

    duration = end_at_as_datetime.present? ? end_at_as_datetime - started_at_as_datetime : 0
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

  def seconds_to_hms(sec)
    "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
  end
end
