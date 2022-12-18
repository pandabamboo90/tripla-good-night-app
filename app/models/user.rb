class User < ApplicationRecord

  # Associations
  has_many :sleep_records
  has_many :friends, through: :users_connections, class_name: 'User'

  # Validations
  validates_presence_of :name

  # Public methods
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
