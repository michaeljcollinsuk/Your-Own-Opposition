require 'rails_helper'

describe Analysis, :type => :class do
  let(:user_urls) {[daily_mail_url, telegraph_url, guardian_url]}

  let(:daily_mail_url) {'http://www.dailymail.co.uk/news/article-3494714/George-Osborne-warn-storm-clouds-gathering-economy-today-s-Budget-generation-money-schools-infrastructure.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/business/2016/03/16/budget-2016-george-osbornes-speech-live0/'}
  let(:guardian_url) {'http://www.theguardian.com/'}


  let(:url_parser_klass) {double :url_parser_klass}
  let(:url_parser) {double :url_parser}

  let(:papers_klass) {double :papers_klass}
  let(:dummy_papers) {double :dummy_papers}

  let(:stubbed_papers) {{dailymail: 100,
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
      allow(url_parser_klass).to receive(:new).and_return(url_parser)
      allow(url_parser_klass).to receive(:papers).and_return(stubbed_papers)
      allow(papers_klass).to receive(:new)
      allow(url_parser).to receive(:papers).and_return(stubbed_papers)
      allow(url_parser).to receive(:news_source_list).and_return([:dailymail, :telegraph, :theguardian])
      allow(url_parser).to receive(:topics_list).and_return([:osborne, :osborne, :osborne, :osborne, :warn, :warn, :storm, :storm])
    end

    describe '#initialize' do
      context 'on #initialize' do

      it 'instantiates a new url_parser' do
        expect(url_parser_klass).to receive(:new)
        url_analysis_klass.new(user_urls, papers_klass, url_parser_klass)
      end

      it 'instantiates a papers object' do
        expect(papers_klass).to receive(:new)
        url_analysis_klass.new(user_urls, papers_klass, url_parser_klass)
      end

    end

      context 'once #initialized' do
        subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass, url_parser_klass)}


        it 'calls the method political_leaning_perc to calculate a bias score' do
          expect(url_analysis.current_bias).to eq(url_analysis.political_leaning_perc)
          url_analysis_klass.new(user_urls, papers_klass, url_parser_klass)
        end

        it 'saves those papers to a papers variable' do
          expect(url_analysis.papers).to eq(stubbed_papers)
          url_analysis_klass.new(user_urls, papers_klass, url_parser_klass)
        end

        it 'stores the results of parsing the users urls in an object' do
          expect(url_analysis.url_parser).to eq(url_parser)
        end

        # it 'calls the method #find_media_diet with topics_to_analyse and stores the result' do
        #   expect(url_analysis.top_topics).to eq(url_analysis.find_media_diet(url_parser.topics_list))
        # end
        #
        # it 'calls the method #find_media_diet with sources_to_analyse and stores the result' do
        #   expect(url_analysis.media_diet).to eq(url_analysis.find_media_diet(url_parser.news_source_list))
        # end


      end

    end

  context 'analysing sources from the parser' do
    subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass, url_parser_klass)}

    describe '#sources_to_analyse' do

      it 'retrieves the news_source_list from url_parser' do
        expect(url_parser).to receive(:news_source_list)
        url_analysis.sources_to_analyse
      end

    end

    describe '#topics_to_analyse' do

      it 'retrieves the news_source_list from url_parser' do
        expect(url_parser).to receive(:topics_list)
        url_analysis.topics_to_analyse
      end

    end
  end

  context 'calculating political bias #political_leaning_scores' do
    subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass, url_parser_klass)}

      describe '#political_leaning_perc' do

        it 'returns a score between -100 and 100 for political leniency' do
          expect(url_analysis.political_leaning_perc).to be_between(-100, 100).inclusive
        end

      end

      describe '#political_leaning_scores' do

      it 'returns an array of the scores out of 100 for political leniencies' do
        expect(url_analysis.political_leaning_scores).to include(80, 100, -100)
      end
    end
  end

  # describe '#find_media_diet' do
  #   subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass, url_parser_klass)}
  #
  #   it 'can use the news source list to find out number of each article read' do
  #     expect(url_analysis.find_media_diet(url_analysis.sources_to_analyse)).to eq({dailymail: 33, telegraph: 33, theguardian: 33})
  #   end
  #
  #   it 'can also use the keyword list to find out how much of one topic read' do
  #     expect(url_analysis.find_media_diet(url_analysis.topics_to_analyse)).to include(:osborne => 50, :warn => 25, :storm => 25)
  #   end
  #
  #
  # end

  describe '#find_right_message' do
    subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass, url_parser_klass)}


    it 'returns an appropriate messaged based on political_leaning_perc' do
      expect(url_analysis.find_right_message).to eq("benefit-scrounger blamer")
    end

  end

end
