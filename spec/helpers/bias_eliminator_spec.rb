require 'rails_helper'

describe BiasEliminator, :type => :class do
  subject(:bias_eliminator_klass) {described_class}
  let(:left_bias_score) {-60}
  let(:right_bias_score) {60}
  let(:balanced_score) {0}
  let(:dummy_papers) {double :dummy_papers}
  let(:source_suggestion_klass) {double :source_suggestion_klass}
  let(:source_suggestion) {double :source_suggestion}

  subject(:bias_eliminator_left) {described_class.new(left_bias_score)}
  subject(:bias_eliminator_right) {described_class.new(right_bias_score)}
  subject(:bias_eliminator_balanced) {described_class.new(balanced_score)}


  before do
    allow(dummy_papers).to receive(:list).and_return({dailymail: 100,
                                                       telegraph: 80,
                                                       bbc: 5,
                                                       theguardian: -100,
                                                       mirror: -80,
                                                       thesun: 100,
                                                       huffingtonpost: -40,
                                                       buzzfeed: -20,
                                                       independent: -20,
                                                       thetimes: 60,
                                                       express: 20,
                                                       morningstar: -60})
    bias_eliminator_left.papers(dummy_papers)
    bias_eliminator_right.papers(dummy_papers)
    bias_eliminator_balanced.papers(dummy_papers)
  end

  describe '#initialize' do

    context 'on #initialize' do

      it 'calls #score_needed with the url analysis\'s bias_score and no_urls' do
        expect_any_instance_of(bias_eliminator_klass).to receive(:calculate_score_needed)
                                                     .and_return(60)
        bias_eliminator_klass.new(left_bias_score)
      end

      it 'calls #filtered_sources to filter sources by opposing political leaning' do
        expect_any_instance_of(bias_eliminator_klass).to receive(:filter_sources)
        bias_eliminator_klass.new(left_bias_score)
      end
    end

    context 'after #initialize' do


      context 'left-wing bias_score' do

        it 'stores the #score_needed based on url analysis\' right-wing bias score' do
          expect(bias_eliminator_left.score_needed).to eq(60)
        end

        it 'stores a hash of sources filtered to reduce user\'s bias' do
          expect(bias_eliminator_left.filtered_sources).to eq({thetimes: 60,
                                                               express: 20,
                                                               bbc: 5})
        end
      end

      context 'right-wing bias_score' do

        it 'stores the #score_needed based on url analysis\' right-wing bias score' do
          expect(bias_eliminator_right.score_needed).to eq(-60)
        end

        it 'stores a hash of sources filtered to reduce user\'s bias' do
          expect(bias_eliminator_right.filtered_sources).to eq({independent: -20,
                                                                huffingtonpost: -40,
                                                                buzzfeed: -20,
                                                                morningstar: -60})
        end
      end
    end
  end

  describe '#new_source_suggester' do

    before do
      allow(source_suggestion_klass).to receive(:new).and_return(source_suggestion)
    end

    it 'instantiates a new instance of source_suggestion' do
      expect(source_suggestion_klass).to receive(:new)
                                     .with(60, bias_eliminator_left.filtered_sources)
      bias_eliminator_left.new_source_suggester(source_suggestion_klass)
    end

  end

  describe '#calculate_score_needed' do

    # it 'returns :balanced if the bias_score is 0' do
    #   expect(bias_eliminator_balanced.calculate_score_needed())
    # end
  end
end
