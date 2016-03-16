require 'rails_helper'

describe Url, type: :model do
  it {is_expected.to belong_to :user}
end
