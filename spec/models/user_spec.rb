require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many(:urls).dependent(:destroy) }
  it { is_expected.to have_many(:analyses).dependent(:destroy) }
end
