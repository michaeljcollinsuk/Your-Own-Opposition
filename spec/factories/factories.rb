FactoryGirl.define do
  factory :url do
    trait :link do
      link 'http://www.theguardian.com/uk-news/2016/mar/17/budget-2016-osborne-chances-of-delivering-surplus-50-50-ifs'
    end
    user
  end

  factory :user do
    trait :email do
    # link 'http://www.theguardian.com/uk-news/2016/mar/17/budget-2016-osborne-chances-of-delivering-surplus-50-50-ifs'
      email 'bob@bob.com'
    end
    trait :password do
      password 'password'
    end
  end

  # factory :daily_mail_user do
  #   link 'http://www.dailymail.co.uk/news/article-3496512/George-Osborne-insists-WON-T-hike-taxes-slash-spending-clear-deficit-watchdogs-warn-s-got-50-50-chance-best.html'
  #   urls
  # end
end
