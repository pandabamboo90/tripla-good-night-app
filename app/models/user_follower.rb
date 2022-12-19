class UserFollower < ApplicationRecord

  self.table_name = 'users_followers'

  # Associations
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'

  # Enums
  enum status: { following: 0, unfollowed: 1 }

  # Validations
  validates_presence_of :user, :follower, :status
end
