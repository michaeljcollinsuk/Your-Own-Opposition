require 'rails_helper'

describe AnalysisHelper, type: :helper do
let(:link) {'http://www.theguardian.com/uk-news/2016/mar/17/budget-2016-osborne-chances-of-delivering-surplus-50-50-ifs'}

  before do
    user = FactoryGirl.create(:user, password: 'password', email: 'bob@bob.com', password_confirmation: 'password')
    FactoryGirl.create(:url, link: link, user: user)
    sign_in user
  end

  describe '#retrieve_urls' do

    it 'returns all the users urls as an array' do
      expect(retrieve_urls).to_include(link)
    end
  end

end
