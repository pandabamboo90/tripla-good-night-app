class UserFollower < ApplicationRecord

  self.table_name = 'users_followers'

  # Enums
  enum status: { following: 0, unfollowed: 1 }

  # Validations
  validates_presence_of :user_id, :following_user_id, :status
  validates_uniqueness_of :user_id, scope: [:following_user_id], message: 'and Following User record already existed'
end
