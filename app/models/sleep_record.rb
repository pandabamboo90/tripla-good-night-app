class SleepRecord < ApplicationRecord

  # Associations
  belongs_to :user

  # Validations
  validates_presence_of :hours, :minutes, :seconds
  validates_numericality_of :hours, :minutes, :seconds, only_integer: true
  
  # Callbacks
  before_save :set_length_as_seconds

  def set_length_as_seconds
    self.length_in_seconds = (hours * 3600) + (minutes * 60) + seconds
  end
end
