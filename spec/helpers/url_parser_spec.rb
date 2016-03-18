require 'rails_helper'

describe UrlParser, :type => :class do
  let(:daily_mail_url) {'http://www.dailymail.co.uk/news/article-3494714/George-Osborne-warn-storm-clouds-gathering-economy-today-s-Budget-generation-money-schools-infrastructure.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/business/2016/03/16/budget-2016-george-osbornes-speech-live0/'}
  let(:guardian_url) {'http://www.theguardian.com/'}
  let(:user_urls) {[daily_mail_url, telegraph_url, guardian_url]}
  let(:dummy_papers) {double :dummy_papers}
  let(:dummy_papers_list) {{dailymail: 100,
                            telegraph: 80,
                            bbc: 5,
                            theguardian: -100,
                            mirror: -80,
                            sun: 100,
                            huffington_post: -40,
                            buzzfeed: -20,
                            independent: -20,
                            thetimes: 60,
                            express: 20,
                            morningstar: -60}}
  subject(:url_parser) {described_class.new(user_urls, dummy_papers)}

before do
  allow(dummy_papers).to receive(:list).and_return(dummy_papers_list)
end

  describe '#parse_source(url)' do

    it 'matches a single url to the main news source name' do
      expect(url_parser.parse_source(daily_mail_url)).to include(:dailymail)
    end

    it 'matches urls against a list of source names' do
      expect(url_parser.parse_source(telegraph_url)).to include(:telegraph)
    end

  end

  describe '#parse_source_history' do

    it 'updates the news_source_list with the names of the matching news sources of urls' do
      url_parser.parse_source_history
      expect(url_parser.news_source_list).to include(:telegraph, :dailymail, :theguardian)
    end

  end

  describe '#parse_keywords_history' do

    before do
      url_parser.parse_source_history
    end

    it 'returns an array of keywords as topics' do
      expect(url_parser.topics_list).to include(:osborne)
    end

    it 'calls parse_source_history so to remove news sources from list' do
      expect(url_parser.topics_list).not_to include(:telegraph)
      expect(url_parser.topics_list).not_to include(:dailymail)
    end

  end

end
