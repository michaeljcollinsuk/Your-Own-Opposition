require 'rails_helper'

describe Suggestion, :type => :class do
  let(:suggestion_klass) {described_class}
  let(:url_analysis) {double :url_analysis}
  let(:bias_score) {double :bias_score}

  let(:frequent_topics_hash) { {politics: 33,
                                cameron: 33,
                                taxes: 33} }
  let(:left_filtered_sources) {{mirror: -80,
                                huffingtonpost: -40,
                                buzzfeed: -20,
                                independent: -20,
                                morningstar: -60}}
  let(:right_filtered_sources) {{telegraph: 80,
                                thetimes: 60,
                                express: 20,
                                bbc: 5}}
  let(:left_score_needed) {-80}
  let(:right_score_needed) {80}
  let(:bias_eliminator_klass) {double :bias_eliminator_klass}
  let(:bias_eliminator) {double :bias_eliminator}
  subject(:suggestion) {described_class.new(url_analysis, bias_eliminator_klass)}

  before do
    allow(url_analysis).to receive(:bias_score).and_return(bias_score)
    allow(url_analysis).to receive(:frequent_topics).and_return(frequent_topics_hash)
    allow(bias_eliminator_klass).to receive(:new).and_return(bias_eliminator)
    allow(bias_eliminator).to receive(:score_needed).and_return(left_score_needed)
    allow(bias_eliminator).to receive(:filtered_sources).and_return(left_filtered_sources)
  end

  describe '#initialize' do

    it 'instantiates a BiasEliminator' do
      expect(bias_eliminator_klass).to receive(:new).with(bias_score)
      suggestion_klass.new(url_analysis, bias_eliminator_klass)
    end

    it 'calls #topic_suggestion with frequent topics to find a top topic' do
      expect_any_instance_of(suggestion_klass).to receive(:topic_suggestion).with(frequent_topics_hash)
      suggestion_klass.new(url_analysis, bias_eliminator_klass)
    end

    it 'calls #top_source to find which you\'d need to read least of to balance your bias' do
      expect_any_instance_of(suggestion_klass).to receive(:top_source)
      suggestion_klass.new(url_analysis, bias_eliminator_klass)
    end
  end

  describe '#recommended_reading' do

    it 'LEFT returns a hash with source and quantity to read as recommended_reading' do
      allow(bias_eliminator).to receive(:score_needed).and_return(left_score_needed)
      allow(bias_eliminator).to receive(:filtered_sources).and_return(left_filtered_sources)
      expect(suggestion.recommended_reading).to eq({mirror: 1,
                                                    independent: 4,
                                                    huffingtonpost: 2,
                                                    buzzfeed: 4,
                                                    morningstar: 1})
    end

    it 'RIGHT returns a hash with source and quantity to read as recommended_reading' do
      allow(bias_eliminator).to receive(:score_needed).and_return(right_score_needed)
      allow(bias_eliminator).to receive(:filtered_sources).and_return(right_filtered_sources)
      expect(suggestion.recommended_reading).to eq({bbc: 16,
                                                    express: 4,
                                                    thetimes: 1,
                                                    telegraph: 1})
    end
  end

  describe '#top_source' do

    it 'LEFT returns an array with the name of the source and quantity to read' do
      allow(bias_eliminator).to receive(:score_needed).and_return(left_score_needed)
      allow(bias_eliminator).to receive(:filtered_sources).and_return(left_filtered_sources)
      expect(suggestion.best_source).to eq([:mirror, 1])
    end

    it 'RIGHT returns an array with the name of the source and quantity to read' do
      allow(bias_eliminator).to receive(:score_needed).and_return(right_score_needed)
      allow(bias_eliminator).to receive(:filtered_sources).and_return(right_filtered_sources)
      expect(suggestion.best_source).to eq([:telegraph, 1])
    end
  end
end
