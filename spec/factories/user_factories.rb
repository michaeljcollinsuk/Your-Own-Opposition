FactoryGirl.define do
  factory :user do
    sequence(:email) { |email| "#{email}@anemail.com" }
    password "password"
  end

  factory :user_with_analyses do
    transient do
      analyses_count 2
    end
    after(:create) do |user, evaluator|
      create_list(:analyses, evaluator.analyses_count, user: user)
    end
  end
end
