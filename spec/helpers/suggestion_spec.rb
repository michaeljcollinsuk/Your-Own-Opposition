require 'rails_helper'

describe Suggestion, :type => :class do
  let(:suggestion_klass) {described_class}
  let(:url_analysis) {double :url_analysis}
  let(:bias_score) {double :bias_score}
  let(:frequent_topics_hash) { {politics: 33,
                                cameron: 33,
                                taxes: 33} }

  let(:bias_eliminator_klass) {double :bias_eliminator_klass}
  let(:bias_eliminator) {double :bias_eliminator}
  let(:source_suggestion) {double :source_suggestion}
  subject(:suggestion) {described_class.new(url_analysis, bias_eliminator_klass)}

  before do
    allow(url_analysis).to receive(:bias_score).and_return(bias_score)
    allow(url_analysis).to receive(:frequent_topics).and_return(frequent_topics_hash)
    allow(bias_eliminator_klass).to receive(:new).and_return(bias_eliminator)
    allow(bias_eliminator).to receive(:new_source_suggester).and_return(source_suggestion)
    allow(source_suggestion).to receive(:top_source)
    allow(source_suggestion).to receive(:recommend_reading)
  end

  describe '#initialize' do

    it 'calls #new_suggestion_requirements with url_analysis bias_score' do
      expect_any_instance_of(suggestion_klass).to receive(:new_suggestion_requirements)
                                              .with(bias_score, bias_eliminator_klass)
                                              .and_return(bias_eliminator)
      suggestion_klass.new(url_analysis, bias_eliminator_klass)
    end

    xit 'calls #source_suggestion twice to find the best source and recommended reading' do
      expect_any_instance_of(suggestion_klass).to receive(:source_suggestion).exactly(2).times
      suggestion_klass.new(url_analysis, bias_eliminator_klass)
    end
  end
end
