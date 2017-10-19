FactoryGirl.define do
  factory :user do
    first_name {FFaker::Name.first_name}
    last_name {FFaker::Name.last_name}
    email {FFaker::Internet.free_email}
    role {["Admin","Other","User"].sample}
    trait :confirmed do
      confirmed_at {DateTime.now}
    end
  end
end
