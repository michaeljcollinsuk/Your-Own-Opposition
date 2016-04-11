FactoryGirl.define do
  factory :analysis do
    bias_score (-100)
    media_diet ({guardian: 100})
    user
  end
end
