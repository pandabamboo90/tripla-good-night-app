class User < ApplicationRecord

  # Associations
  has_many :friends, through: :user_friend, class_name: User

  # Validations
  validates_presence_of :name

end
