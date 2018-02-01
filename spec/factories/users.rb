FactoryBot.define do
  factory :user do
    email    { Faker::Internet.email }
    password { Faker::Internet.password }
    admin false
  end

  factory :admin, class: User do
    email    { Faker::Internet.email }
    password { Faker::Internet.password }
    admin true
  end
end
