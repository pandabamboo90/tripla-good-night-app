def seed_1w_sleep_record(user:)
  for idx in -6..0
    today = Time.zone.now
    started_at = today + idx.day
    ended_at = started_at + (Faker::Number.between(from: 4, to: 10).round(2)).hours

    sleep_record_params = {
      started_at: started_at,
      ended_at: ended_at
    }.with_indifferent_access
    user.add_sleep_record!(sleep_record_params: sleep_record_params)
  end
end


ActiveRecord::Base.transaction do
  5.times do |idx|
    user = User.create!(name: Faker::Name.name)

    seed_1w_sleep_record(user: user)
  end
end
