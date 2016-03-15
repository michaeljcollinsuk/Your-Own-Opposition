require 'rails_helper'

describe Suggestion, :type => :class do
  let(:dummy_url_analysis_klass) {double :dummy_url_analysis_klass}
  let(:dummy_url_analysis) {double :dummy_url_analysis}
  let(:dummy_urls) {['a', 'b']}
  subject(:suggestion) {described_class.new(dummy_url_analysis_klass, dummy_urls)}
  let(:dummy_papers) {{dailymail: 100,
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
  let(:leftwing_score) {-40}
  let(:rightwing_score) {90}

  before do
    allow(dummy_url_analysis_klass).to receive(:new).and_return(dummy_url_analysis)
    allow(dummy_url_analysis).to receive(:papers).and_return(dummy_papers)
    allow(dummy_url_analysis).to receive(:political_leaning_perc).and_return(leftwing_score)
    allow(suggestion).to receive(:left_needed?)
  end

  describe '#initialize' do

    it 'is instantiated with a UrlCalculator klass' do
      expect(suggestion.url_analysis).to eq(dummy_url_analysis_klass)
    end

    it 'is instantiated with an empty hash of suggested sources' do
      expect(suggestion.suggested_sources).to eq({})
    end

    it 'is instantiated with an array of urls' do
      expect(suggestion.urls).to eq(dummy_urls)
    end

    context 'no urls supplied' do
      subject(:suggestion_no_urls) {described_class.new(dummy_url_analysis_klass)}

      it 'defaults to an empty array if no urls are given to make a suggestion' do
        expect(suggestion_no_urls.urls).to be_empty
      end

    end
  end

  describe '#news_source' do

    it 'instantiates a new instance of url analysis with the suggestions urls' do
      expect(dummy_url_analysis_klass).to receive(:new).with(dummy_urls)
      suggestion.news_source
    end

    it 'calculates the score needed based on current political leaning score' do
      expect(dummy_url_analysis).to receive(:political_leaning_perc)
      suggestion.news_source
    end

    it 'calls find_suggestions with the score needed' do
      expect(suggestion).to receive(:eliminate_bias).with(-40)
      suggestion.news_source
    end


    describe '#eliminate_bias' do

      it 'calculates the score you need to balance your current bias score' do
        expect(suggestion).to receive(:find_suggestion).with(-60)
        suggestion.news_source
      end

      context '#no urls to analyse/ balanced reading' do
        subject(:suggestion_no_urls) {described_class.new(dummy_url_analysis_klass)}

        before do
          allow(dummy_url_analysis).to receive(:political_leaning_perc).and_return(0)
        end

        it 'does not try to generate a suggestion if no urls have been given' do
          expect(suggestion_no_urls).not_to receive(:find_suggestion)
          suggestion_no_urls.news_source
        end

        it 'does not try to generate a suggestion if you are already balanced' do
          expect(suggestion_no_urls).not_to receive(:find_suggestion)
          suggestion_no_urls.news_source
        end

        it 'returns ":balanced" when given no urls or have a score of 0' do
          expect(suggestion_no_urls.news_source).to eq(:balanced)
        end
      end
    end

    describe '#find_suggestion' do
      subject(:suggestion) {described_class.new(dummy_url_analysis_klass, dummy_urls)}

      before do
        suggestion.news_source
      end

      it 'fetches the papers hash' do
        expect(dummy_url_analysis).to receive(:papers)
        suggestion.find_suggestion(10)
      end

      it 'selects news sources that match the score you need to be balanced' do
        expect(suggestion.find_suggestion(-60)).to include(:morningstar)
        expect(suggestion.find_suggestion(20)).to include(:dailyexpress)
      end

      it 'returns an array of more than one source if many matches found' do
        expect(suggestion.find_suggestion(-20)).to include(:independent, :buzzfeed)
      end

      it 'updates the suggested_sources hash with suggestions for political jolt' do
        suggestion.find_suggestion(-20)
        expect(suggestion.suggested_sources[:political_jolt]).to eq([:buzzfeed, :independent])
      end

      it 'calls #find_many_suggestions if no single match is found' do
        expect(suggestion).to receive(:find_many_suggestions).with(10, dummy_papers)
        suggestion.find_suggestion(10)
      end

    end

    describe '#find_many_suggestions' do

      context '#right wing needed' do
        before do
          suggestion.news_source
        end

        it 'decides if you need leftwing news based on +ve score needed' do
          expect(suggestion).to receive(:left_needed?).with(10).and_return(false)
          suggestion.find_suggestion(10)
        end

        it 'it calls #filter_sources with ":right"' do
          expect(suggestion).to receive(:filter_sources).with(:right, dummy_papers)
          suggestion.find_suggestion(10)
        end
      end

      context '#right wing needed' do

        before do
          allow(dummy_url_analysis).to receive(:political_leaning_perc).and_return(rightwing_score)
        end



        it 'decides if you need leftwing news based on -ve score needed' do
          expect(suggestion).to receive(:left_needed?).and_return(true)
          suggestion.news_source
        end

        xit 'it calls #filter_sources with ":left"' do
          expect(suggestion).to receive(:filter_sources).with(:left, dummy_papers)
          suggestion.news_source
          # suggestion.find_suggestion(-10)
        end
      end


      xit 'it updates the suggested_sources hash ' do
        # expect(suggestion.)
      end
    end
  end
end
