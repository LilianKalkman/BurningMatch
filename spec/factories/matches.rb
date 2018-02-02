FactoryBot.define do
  factory :match do
    date        { Faker::Date.between(2.days.ago, Date.today)}
    student1_id "1"
    student2_id "2"
  end

end
