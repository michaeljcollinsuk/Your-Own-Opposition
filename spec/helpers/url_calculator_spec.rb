require 'rails_helper'

describe Url_calculator do
  let(:dummy_selection) {double :user_urls}
  subject(:url_calculator) {described_class.new(user_urls)}
  let(:papers) {{dailymail: right,
                 telegraph: right,
                 bbc: center,
                 guardian: left,
                 mirror: left,
                 sun: right,
                 huffington_post: center-left,
                 buzzfeed: left,
                 independent: center-left,
                 the_times: center-right}}
  let(:daily_mail_url) {'http://www.dailymail.co.uk/home/index.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/'}

  describe '#initialize' do

    it 'has a hash of papers matched to their political leniencies'
      expect(url_calculator.papers).to eq(papers)
    end

  end

  describe '#url_analyser' do

  it 'matches a single url to the main news source name' do
    expect(url_analyser(daily_mail_url)).to eq({daily_mail: 1})
  end

  it 'matches urls against a list of source names' do
    expect(url_analyser(telegraph_url)).to eq({telegraph: 1})
  end

  describe '#url_history_update' do
    xit 'is updates the hash with recent url history' do
      # expect(url_matchers(url))
    end
  end
end
