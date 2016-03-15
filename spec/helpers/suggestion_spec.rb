require 'rails_helper'

describe Suggestion, :type => :class do
  let(:dummy_url_analysis_klass) {double :dummy_url_analysis_klass}
  let(:dummy_url_analysis) {double :dummy_url_analysis}
  subject(:suggestion) {described_class.new(dummy_url_analysis_klass)}
  let(:dummy_papers) {{dailymail: 100,
                telegraph: 80,
                bbc: 5,
                theguardian: -100,
                mirror: -80,
                sun: 100,
                huffington_post: -40,
                buzzfeed: -20,
                independent: -20,
                thetimes: 20}}

  describe '#initialize' do

    it 'is instantiated with a UrlCalculator klass' do
      expect(suggestion.url_analysis).to eq(dummy_url_analysis_klass)
    end

    it 'is instantiated with an empty hash of suggested sources' do
      expect(suggestion.suggested_sources).to eq({})
    end
  end

  describe '#news_source' do
    let(:leftwing_score) {-5}
    let(:rightwing_score) {27}

    before do
      allow(dummy_url_analysis_klass).to receive(:new).and_return(dummy_url_analysis)
      allow(dummy_url_analysis).to receive(:papers).and_return(dummy_papers)
      allow(dummy_url_analysis).to receive(:political_leaning_perc).and_return(leftwing_score)

    end

    it 'instantiates a new instance of url analysis' do
      expect(dummy_url_analysis_klass).to receive(:new)
      suggestion.news_source
    end

    it 'retrieves the papers and their political leaning scores' do
      expect(dummy_url_analysis).to receive(:political_leaning_perc)
      suggestion.news_source
    end

    it 'calls calculate_matches' do
      expect(suggestion).to receive(:bias_eliminator).with(-5)
      suggestion.news_source
    end


    describe '#bias_eliminator' do

      before do
        suggestion.news_source
      end

      xit 'suggests a news source to read based on bringing political leaning to 0' do

      end
    end
  end
end
