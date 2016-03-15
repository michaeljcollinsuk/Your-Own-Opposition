require 'rails_helper'

describe UrlCalculator, :type => :class do
  subject(:url_calculator) {described_class.new}
  let(:user_urls) {double :dummy_urls}
  let(:papers) {{dailymail: :right,
                 telegraph: :right,
                 bbc: :center,
                 guardian: :left,
                 mirror: :left,
                 sun: :right,
                 huffington_post: :center_left,
                 buzzfeed: :left,
                 independent: :center_left,
                 thetimes: :center_right}}
  let(:daily_mail_url) {'http://www.dailymail.co.uk/home/index.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/'}

    describe '#initialize' do

      it 'has a hash of papers matched to their political leniencies' do
        expect(url_calculator.papers).to eq(papers)
      end

      it 'has an empty hash for analysed_urls' do
        expect(url_calculator.analysed_urls).to eq({})
      end

      it 'defaults user_urls input to an empty array if no ' do
        expect(url_calculator.analysed_urls).to be_empty
      end

    end

    describe '#url_analyser' do

    it 'matches a single url to the main news source name' do
      expect(url_calculator.url_analyser(daily_mail_url)).to eq({dailymail: :right})
    end

    it 'matches urls against a list of source names' do
      expect(url_analyser(telegraph_url)).to eq({telegraph: 1})
    end

    describe '#url_history_update' do
      it 'is updates the hash with recent url history' do
        # expect(url_matchers(url))
      end
    end
  end
end
