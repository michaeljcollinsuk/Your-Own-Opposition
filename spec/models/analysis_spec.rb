require 'rails_helper'

describe Analysis, type: :model do
  it {is_expected.to belong_to :user}
  it {is_expected.to validate_presence_of :user}
  it {is_expected.to validate_presence_of :bias_score}

end
