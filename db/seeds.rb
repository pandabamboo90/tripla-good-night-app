ActiveRecord::Base.transaction do
  5.times do |idx|
    User.create!(name: Faker::Name.name)
  end
end
