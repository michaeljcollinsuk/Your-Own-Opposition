FactoryGirl.define do
  factory :url do
    trait :link do
      link 'http://www.theguardian.com/uk-news/2016/mar/17/budget-2016-osborne-chances-of-delivering-surplus-50-50-ifs'
    end
    user
  end

  factory :user do
    trait :email do
      email 'bob@bob.com'
    end
    trait :password do
      password 'password'
    end
  end
end
