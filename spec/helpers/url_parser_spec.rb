require 'rails_helper'

describe UrlParser, :type => :class do
  let(:daily_mail_url) {'http://www.dailymail.co.uk/news/article-3494714/George-Osborne-warn-storm-clouds-gathering-economy-today-s-Budget-generation-money-schools-infrastructure.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/business/2016/03/16/budget-2016-george-osbornes-speech-live0/'}
  let(:guardian_url) {'http://www.theguardian.com/business/Budget'}
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

  describe '#news_source_list' do

    it 'calls extract_sources with an individual url' do
      expect(url_parser).to receive(:extract_sources).exactly(user_urls.length).times
      url_parser.news_source_list
    end

    it 'turns the array of user urls into an array of news source names' do
      expect(url_parser.news_source_list).to include(:telegraph, :dailymail, :theguardian)
    end

  end

  describe '#topics_list' do

    it 'returns an array of keywords as topics' do
      expect(url_parser.topics_list).to include(:osborne, :speech)
    end

    it 'calls extract_keywords with each url, plus once for news source list' do
      expect(url_parser).to receive(:extract_keywords)
      url_parser.topics_list
    end

    it 'calls news_source_list so to remove news sources from list' do
      expect(url_parser.topics_list).not_to include(:telegraph)
      expect(url_parser.topics_list).not_to include(:dailymail)
    end


  end

end
