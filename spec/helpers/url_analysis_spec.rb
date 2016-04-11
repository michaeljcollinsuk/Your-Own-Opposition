require 'rails_helper'

describe UrlAnalysis, :type => :class do
  let(:daily_mail_url) {'http://www.dailymail.co.uk/news/article-3494714/George-Osborne-warn-storm-clouds-gathering-economy-today-s-Budget-generation-money-schools-infrastructure.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/business/2016/03/16/budget-2016-george-osbornes-speech-live0/'}
  let(:guardian_url) {'http://www.theguardian.com/'}
  let(:user_urls) {[daily_mail_url, telegraph_url, guardian_url]}

  let(:url_parser_klass) {double :url_parser_klass}
  let(:url_parser) {double :url_parser}

  let(:papers) {double :papers}

  let(:media_diet_klass) {double :media_diet_klass}
  let(:media_diet) {double :media_diet}

  let(:bias) {double :bias}

  subject(:analysis_klass) {described_class}
  subject(:analysis) {described_class.new(user_urls, url_parser_klass)}

    before do
      allow(media_diet_klass).to receive(:new).and_return(media_diet)
      allow(media_diet).to receive(:current_bias).and_return(bias)
      allow(url_parser_klass).to receive(:new).and_return(url_parser)
      allow(url_parser).to receive(:news_source_list).and_return([:dailymail, :telegraph, :theguardian])
      allow(url_parser).to receive(:topics_list).and_return([:osborne, :osborne, :osborne, :osborne, :warn, :warn, :storm, :storm])
    end

  describe '#initialize' do

    context 'on #initialize' do

      it 'instantiates a new url_parser' do
        expect(url_parser_klass).to receive(:new)
        analysis_klass.new(user_urls, url_parser_klass)
      end

      it 'calls media_diet_calculations twice, 1ce for topics, 1 for sources' do
        expect_any_instance_of(analysis_klass).to receive(:media_diet_calculations).exactly(2).times
        analysis_klass.new(user_urls, url_parser_klass)
      end

      it 'calls retrieve_bias once, using sources to analyse' do
        expect_any_instance_of(analysis_klass).to receive(:retrieve_bias).with(analysis.sources_to_analyse)
        analysis_klass.new(user_urls, url_parser_klass)
      end
    end

    context 'once #initialized' do

      it 'stores a hash representing the users media diet' do
        expect(analysis.media_diet).to eq({:dailymail=>33, :telegraph=>33, :theguardian=>33})
      end

      it 'stores a hash representing the users media diet, topics' do
        expect(analysis.frequent_topics).to eq({:osborne=>50, :warn=>25, :storm=>25})
      end

      it 'stores the results of parsing the users urls in an object' do
        expect(analysis.url_parser).to eq(url_parser)
      end

    end

  end

  context 'analysing sources from the parser' do

    describe '#sources_to_analyse' do

      it 'retrieves the news_source_list from url_parser' do
        expect(url_parser).to receive(:news_source_list)
        analysis.sources_to_analyse
      end

    end

    describe '#topics_to_analyse' do

      it 'retrieves the news_source_list from url_parser' do
        expect(url_parser).to receive(:topics_list)
        analysis.topics_to_analyse
      end

    end

    describe '#media_diet_calculations' do

      before do
        allow(media_diet).to receive(:analyse_composition)
        allow(media_diet).to receive(:composition)
      end

      it 'calls #new_media_diet' do
        expect(analysis).to receive(:new_media_diet).and_return(media_diet)
        analysis.media_diet_calculations(analysis.sources_to_analyse)
      end

      it 'calls #analyse_composition on an instance of media diet' do
        allow(analysis).to receive(:new_media_diet).and_return(media_diet)
        expect(media_diet).to receive(:analyse_composition)
        analysis.media_diet_calculations(analysis.sources_to_analyse)
      end

      it 'returns the composition of the media diet' do
        allow(analysis).to receive(:new_media_diet).and_return(media_diet)
        expect(media_diet).to receive(:composition)
        analysis.media_diet_calculations(analysis.sources_to_analyse)
      end

    end

    describe '#new_media_diet' do

      it 'instantiates a new instance of media_diet with sources to analyse' do
        expect(media_diet_klass).to receive(:new).with(analysis.sources_to_analyse)
        analysis.new_media_diet(analysis.sources_to_analyse, media_diet_klass)
      end

      it 'instantiates a new instance of media_diet with topics to analyse' do
        expect(media_diet_klass).to receive(:new).with(analysis.topics_to_analyse)
        analysis.new_media_diet(analysis.topics_to_analyse, media_diet_klass)
      end

    end

    describe '#retrieve_bias' do

      before do
        allow(media_diet).to receive(:current_bias).and_return(bias)
      end

      it 'calls #new_media_diet with sources to analyse' do
        expect(analysis).to receive(:new_media_diet).and_return(media_diet)
        analysis.retrieve_bias(analysis.sources_to_analyse)
      end

      it 'calls #current_bias on media_diet' do
        allow(analysis).to receive(:new_media_diet).and_return(media_diet)
        expect(media_diet).to receive(:current_bias)
        analysis.retrieve_bias(analysis.sources_to_analyse)
      end
    end

  end
end
