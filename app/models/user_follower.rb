class UserFollower < ApplicationRecord

  self.table_name = 'users_followers'

  # Enums
  enum status: { following: 0, unfollowed: 1 }

  # Validations
  validates_presence_of :user_id, :following_user_id, :status
end
