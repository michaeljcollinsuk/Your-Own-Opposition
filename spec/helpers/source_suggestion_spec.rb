require 'rails_helper'

describe SourceSuggestion, :type => :class do
  let(:dummy_bias_eliminator_right) {double :dummy_bias_eliminator_right}
  let(:dummy_bias_eliminator_left) {double :dummy_bias_eliminator_right}

  let(:left_filtered_sources) {{independent: -20,
                                huffingtonpost: -40,
                                buzzfeed: -20,
                                morningstar: -60}}

  let(:right_filtered_sources) {{thetimes: 60,
                                 express: 20,
                                 bbc: 5}}
  let(:right_score_needed) {60}
  let(:left_score_needed) {-60}
  subject(:source_suggestion_klass) {described_class}
  subject(:source_suggestion_right) {described_class.new(dummy_bias_eliminator_right)}
  subject(:source_suggestion_left) {described_class.new(dummy_bias_eliminator_left)}

  before do
    allow(dummy_bias_eliminator_right).to receive(:filtered_sources)
                                      .and_return(right_filtered_sources)
    allow(dummy_bias_eliminator_right).to receive(:score_needed)
                                      .and_return(right_score_needed)
    allow(dummy_bias_eliminator_left).to receive(:filtered_sources)
                                      .and_return(left_filtered_sources)
    allow(dummy_bias_eliminator_left).to receive(:score_needed)
                                      .and_return(left_score_needed)
  end

  describe '#initialize' do

    context 'on #initialize' do

      it 'calls #recommend_reading to get the recommended reading list' do
        expect_any_instance_of(source_suggestion_klass).to receive(:recommend_reading)
                                                       .and_return({bbc: 12,
                                                                    express: 3,
                                                                    thetimes: 1})
        source_suggestion_klass.new(dummy_bias_eliminator_right)
      end

      it 'calls #find_best_suggestion for most effective source to eliminate bias' do
        expect_any_instance_of(source_suggestion_klass).to receive(:find_best_suggestion)
        source_suggestion_klass.new(dummy_bias_eliminator_right)
      end

    end

    context 'once #initialized' do

      it 'stores an instance of bias_eliminator as requirements' do
        expect(source_suggestion_left.requirements).to eq(dummy_bias_eliminator_left)
        expect(source_suggestion_right.requirements).to eq(dummy_bias_eliminator_right)
      end

      it 'LEFT stores a hash with source and quantity to read as recommended_reading' do
        expect(source_suggestion_left.recommended_reading).to eq({independent: 3,
                                                                  huffingtonpost: 1,
                                                                  buzzfeed: 3,
                                                                  morningstar: 1})
      end

      it 'RIGHT stores a hash with source and quantity to read as recommended_reading' do
        expect(source_suggestion_right.recommended_reading).to eq({bbc: 12,
                                                                   express: 3,
                                                                  thetimes: 1})
      end

      it 'LEFT stores the best suggestion, as the recommended source with least quantity to read' do
        expect(source_suggestion_left.best_source).to eq([:huffingtonpost, 1])
        expect(source_suggestion_right.best_source).to eq([:thetimes, 1])
      end

      it 'RIGHT stores the best suggestion, as the recommended source with least quantity to read' do
        expect(source_suggestion_right.best_source).to eq([:thetimes, 1])
      end


    end
  end
end
