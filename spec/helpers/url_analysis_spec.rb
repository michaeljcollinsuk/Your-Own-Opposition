require 'rails_helper'

describe UrlAnalysis, :type => :class do
  let(:user_urls) {[daily_mail_url, telegraph_url, guardian_url]}

  let(:daily_mail_url) {'http://www.dailymail.co.uk/news/article-3494714/George-Osborne-warn-storm-clouds-gathering-economy-today-s-Budget-generation-money-schools-infrastructure.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/business/2016/03/16/budget-2016-george-osbornes-speech-live0/'}
  let(:guardian_url) {'http://www.theguardian.com/'}


  let(:url_parser_klass) {double :url_parser_klass}
  let(:url_parser) {double :url_parser}

  let(:papers_klass) {double :papers_klass}
  let(:papers) {double :papers}

  let(:mocked_papers) {{dailymail: 100,
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

    subject(:url_analysis_klass) {described_class}

    before do
      allow(url_parser_klass).to receive(:new).with(user_urls, papers_klass).and_return(url_parser)
      allow(papers_klass).to receive(:new).and_return(papers)
      allow(papers).to receive(:list).and_return(mocked_papers)
      allow(url_parser).to receive(:papers)
      allow(url_parser).to receive(:user_urls).and_return(user_urls)
      allow(url_parser).to receive(:news_source_list).and_return(:dailymail, :telegraph, :theguardian)
    end

    describe '#initialize' do
      context 'on #initialization' do

      it 'instantiates a new url_parser' do
        expect(url_parser_klass).to receive(:new).with(user_urls, papers)
        url_analysis_klass.new(user_urls, papers_klass, url_parser_klass)
      end

      it 'retrieves a hash of papers matched to their political leniencies' do
        expect(url_calculator.papers).to eq(mocked_papers)
      end

    end
      context 'once #initialized' do
        subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass)}


        it 'stores the results of parsing the users urls in an object' do
          expect(url_calculator_used.url_parser).to eq(url_parser)
        end

        it 'has a hash to aggregate news source list with % of media diet' do
          expect(url_calculator.media_diet).to eq({:dailymail=>33, :telegraph=>33, :theguardian=>33})
        end

        it 'has a hash to hold aggregate topics list' do
          expect(url_calculator.top_topics).to include(:osborne => 4, :warn => 4, :storm => 4, :clouds => 4)
        end


      end

      # it 'defaults user_urls input to an empty array if no array supplied' do
      #   expect(url_calculator.user_urls).to eq([daily_mail_url, telegraph_url, guardian_url])
      # end
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
    subject(:url_calculator_used) {described_class.new(user_urls, papers_klass)}

    before do
      allow(url_parser).to receive(:news_source_list).and_return([:dailymail, :telegraph, :theguardian])
      allow(url_parser).to receive(:topics_list).and_return([:osborne, :osborne, :osborne, :osborne, :warn, :warn, :storm, :storm])
      url_calculator_used.current_bias
    end

    it 'can use the news source list to find out number of each article read' do
      sources_to_analyse = url_parser.news_source_list
      expect(url_calculator_used.find_media_diet(sources_to_analyse)).to eq({dailymail: 33, telegraph: 33, theguardian: 33})
    end

    it 'can also use the keyword list to find out how much of one topic read' do
      topics_list = url_parser.topics_list
      expect(url_calculator_used.find_media_diet(topics_list)).to include(:osborne => 50, :warn => 25, :storm => 25)
    end


  end


end
