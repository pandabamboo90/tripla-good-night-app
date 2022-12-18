class UserConnection < ApplicationRecord

  self.table_name = 'users_connections'

  # Associations
  belongs_to :source_user, class_name: 'User', foreign_key: 'source_user_id'
  belongs_to :target_user, class_name: 'User', foreign_key: 'target_user_id'

  # Enums
  enum status: { friend_request_sent: 0, friend_request_accepted: 1, be_friended: 2, unfriended: 3 }

  # Validations
  validates_presence_of :source_user, :target_user, :status

  # Callbacks
  before_save :validate_uniqueness_of_connection

  def validate_uniqueness_of_connection
    where(source_user_id: self.source_user_id, target_user_id: self.target_user_id)
      .or.where(source_user_id: self.target_user_id, target_user_id: self.source_user_id)
      .blank?
  end

end
