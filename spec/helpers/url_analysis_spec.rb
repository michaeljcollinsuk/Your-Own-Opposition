require 'rails_helper'

describe UrlAnalysis, :type => :class do
  let(:daily_mail_url) {'http://www.dailymail.co.uk/news/article-3494714/George-Osborne-warn-storm-clouds-gathering-economy-today-s-Budget-generation-money-schools-infrastructure.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/business/2016/03/16/budget-2016-george-osbornes-speech-live0/'}
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
        expect(url_calculator.media_diet).to be_empty
      end

      it 'has an empty hash to aggregate topics list' do
        expect(url_calculator.media_diet).to be_empty
      end


      context '#initialized with a url array' do
        subject(:url_calculator_used) {described_class.new(user_urls)}

        it 'stores the user\'s original url history in the calculator' do
          expect(url_calculator_used.user_urls).to eq(user_urls)
        end

      end

    end

  describe '#parse_source(url)' do

    it 'matches a single url to the main news source name' do
      expect(url_calculator.parse_source(daily_mail_url)).to include(:dailymail)
    end

    it 'matches urls against a list of source names' do
      expect(url_calculator.parse_source(telegraph_url)).to include(:telegraph)
    end

  end



  describe '#parse_source_history' do

    it 'calls parse_keywords_history in order to update the topics list' do
      expect(url_calculator_used).to receive(:parse_keywords_history)
      url_calculator_used.parse_source_history
    end

    it 'updates the news_source_list with the names of the matching news sources of urls' do
      url_calculator_used.parse_source_history
      expect(url_calculator_used.news_source_list).to include(:telegraph, :dailymail, :theguardian)
    end



  end

  describe '#parse_keywords_history' do

    before do
      url_calculator_used.parse_source_history
    end

    it 'returns an array of keywords as topics' do
      expect(url_calculator_used.topics_list).to include(:osborne)
    end

    it 'calls parse_source_history so to remove news sources from list' do
      expect(url_calculator_used.topics_list).not_to include(:telegraph)
      expect(url_calculator_used.topics_list).not_to include(:dailymail)
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

  describe '#find_media_diet' do
    subject(:url_calculator_used) {described_class.new(user_urls)}


    it 'can use the news source list to find out number of each article read' do
      url_calculator_used.political_leaning_perc
      news_source_list = url_calculator_used.news_source_list
      expect(url_calculator_used.find_media_diet(news_source_list)).to eq({dailymail: 33, telegraph: 33, theguardian: 33})
    end

    it 'can also use the keyword list to find out how much of one topic read' do
      url_calculator_used.political_leaning_perc
      topics_list = url_calculator_used.topics_list
      expect(url_calculator_used.find_media_diet(topics_list)).to include({osborne: 0})
    end


  end


end
