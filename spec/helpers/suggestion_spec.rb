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
  end

  describe '#news_source' do
    let(:leftwing_score) {-40}
    let(:rightwing_score) {27}

    before do
      allow(dummy_url_analysis_klass).to receive(:new).with(dummy_urls).and_return(dummy_url_analysis)
      allow(dummy_url_analysis).to receive(:papers).and_return(dummy_papers)
      allow(dummy_url_analysis).to receive(:political_leaning_perc).and_return(leftwing_score)
    end

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
    end
  end
end
