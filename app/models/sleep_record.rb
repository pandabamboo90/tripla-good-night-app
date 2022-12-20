class SleepRecord < ApplicationRecord

  # Associations
  belongs_to :user

  # Enums
  enum status: { recording: 0, ended: 1 }

  # Validations
  validates_presence_of :started_at, :hours, :minutes, :seconds, :duration, :status
  validates_numericality_of :hours, :minutes, :seconds, :duration, only_integer: true, greater_than_or_equal_to: 0
  
  # Callbacks
  before_save :set_status

  def set_status
    self.status = self.ended_at.present? ? :ended : :recording
  end
end
