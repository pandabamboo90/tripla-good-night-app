class User < ApplicationRecord

  # Associations
  has_many :friends, through: :users_connections, class_name: 'User'

  # Validations
  validates_presence_of :name

end
