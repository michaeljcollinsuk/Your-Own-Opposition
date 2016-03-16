require 'rails_helper'

describe UrlAnalysis, :type => :class do
  let(:daily_mail_url) {'http://www.dailymail.co.uk/home/index.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/'}
  let(:guardian_url) {'http://www.theguardian.com/'}
  let(:user_urls) {[daily_mail_url, telegraph_url, guardian_url]}
  subject(:url_calculator) {described_class.new}

  subject(:url_calculator_used) {described_class.new(user_urls)}
  let(:papers) {{dailymail: 100,
                telegraph: 80,
                bbc: 5,
                theguardian: -100,
                mirror: -80,
                sun: 100,
                huffington_post: -40,
                buzzfeed: -20,
                independent: -20,
                thetimes: 60,
                dailyexpress: 20,
                morningstar: -60}}



    describe '#initialize' do

      it 'has a hash of papers matched to their political leniencies' do
        expect(url_calculator.papers).to eq(papers)
      end

      it 'has an empty hash for analysed_urls' do
        expect(url_calculator.news_source_list).to be_empty
      end

      it 'defaults user_urls input to an empty array if no array supplied' do
        expect(url_calculator.user_urls).to be_empty
      end

      it 'has an empty hash to aggregate news source list with % of media diet' do
        expect(url_calculator.aggregated_news_source_list).to be_empty
      end


      context '#initialized with a url array' do
        subject(:url_calculator_used) {described_class.new(user_urls)}

        it 'stores the user\'s original url history in the calculator' do
          expect(url_calculator_used.user_urls).to eq(user_urls)
        end

      end

    end

  describe '#parse(url)' do

    it 'matches a single url to the main news source name' do
      expect(url_calculator.parse(daily_mail_url)).to include(:dailymail)
    end

    it 'matches urls against a list of source names' do
      expect(url_calculator.parse(telegraph_url)).to include(:telegraph)
    end

  end

  describe '#parse_history' do

    it 'updates the news_source_list with the names of the matching news sources of urls' do
      url_calculator_used.parse_history
      expect(url_calculator_used.news_source_list).to include(:telegraph, :dailymail, :theguardian)
    end

  end

  describe '#list_political_leaning_scores' do

    it 'returns an array of the scores out of 100 for political leniencies' do
      expect(url_calculator_used.political_leaning_scores).to include(80, 100, -100)
    end
  end

  describe '#political_leaning_perc' do


    it 'returns a score between -100 and 100 for political leniency' do
      expect(url_calculator_used.political_leaning_perc).to eq(26)
    end

  end


end