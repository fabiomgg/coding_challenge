FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "User #{n}" }
    password { "Abc_123_cde" }
  end
end
