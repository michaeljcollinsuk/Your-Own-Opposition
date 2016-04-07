require 'rails_helper'

describe Analysis, :type => :class do
  let(:daily_mail_url) {'http://www.dailymail.co.uk/news/article-3494714/George-Osborne-warn-storm-clouds-gathering-economy-today-s-Budget-generation-money-schools-infrastructure.html'}
  let(:telegraph_url) {'http://www.telegraph.co.uk/business/2016/03/16/budget-2016-george-osbornes-speech-live0/'}
  let(:guardian_url) {'http://www.theguardian.com/'}
  let(:user_urls) {[daily_mail_url, telegraph_url, guardian_url]}

  let(:url_parser_klass) {double :url_parser_klass}
  let(:url_parser) {double :url_parser}

  let(:papers) {double :papers}

  let(:media_diet_klass) {double :media_diet_klass}
  let(:media_diet) {double :media_diet}

  let(:dummy_bias) {double :dummy_bias}

  subject(:analysis_klass) {described_class}
  subject(:analysis) {described_class.new(user_urls, url_parser_klass, media_diet_klass)}

    before do
      allow(media_diet_klass).to receive(:new).and_return(media_diet)
      allow(media_diet).to receive(:current_bias).with(url_parser).and_return(dummy_bias)

      allow(url_parser_klass).to receive(:new).and_return(url_parser)
      allow(url_parser_klass).to receive(:papers).and_return(url_parser)

      allow(url_parser).to receive(:papers).and_return(papers)
      allow(url_parser).to receive(:news_source_list).and_return([:dailymail, :telegraph, :theguardian])
      allow(url_parser).to receive(:topics_list).and_return([:osborne, :osborne, :osborne, :osborne, :warn, :warn, :storm, :storm])
    end

  describe '#initialize' do

    context 'on #initialize' do

      it 'instantiates a new url_parser' do
        expect(url_parser_klass).to receive(:new)
        analysis_klass.new(user_urls, url_parser_klass, media_diet_klass)
      end

      it 'instantiates a two media diet analyses, 1 for topics, 1 for sources' do
        expect(media_diet_klass).to receive(:new).exactly(2).times
        analysis_klass.new(user_urls, url_parser_klass, media_diet_klass)
      end
    end

    context 'once #initialized' do

      it 'calls the #current_bias on media diet to calculate a bias score' do
        expect(media_diet).to receive(:current_bias)
        analysis.bias
      end

      it 'calls #current_bias on media diet using urls parser\'s #papers' do
        expect(url_parser_klass).to receive(:papers)
        analysis.bias
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

  end
end
