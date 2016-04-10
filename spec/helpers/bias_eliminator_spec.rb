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

    it 'returns :balanced if the bias_score is 0' do
      expect(bias_eliminator_balanced.calculate_score_needed).to eq(:balanced)
    end

    it 'returns the bias_score *-1' do
      expect(bias_eliminator_right.calculate_score_needed).to eq(-60)
      expect(bias_eliminator_left.calculate_score_needed).to eq(60)
    end
  end

  describe '#filter_sources' do

    context 'already balanced' do

      it 'checks if the bias_score is already_balanced?' do
        expect(bias_eliminator_balanced).to receive(:already_balanced?).and_return(true)
        bias_eliminator_balanced.filter_sources
      end

      it 'returns :balanced if the bias_score is 0' do
        expect(bias_eliminator_balanced.filter_sources).to eq(:balanced)
      end

      it 'does not attempt to select papers if the bias score is already balanced' do
        expect(bias_eliminator_balanced).not_to receive(:papers)
        bias_eliminator_balanced.filter_sources
      end

    end

    context 'right-wing' do

      it 'checks if the bias_score is already_balanced?' do
        expect(bias_eliminator_right).to receive(:already_balanced?).and_return(false)
        bias_eliminator_right.filter_sources
      end

      # it 'selects the paper sources that have a bias rating between score_needed and 0' do
      #   expect(bias_eliminator_right).to receive(:papers)
      #   bias_eliminator_right.filter_sources
      # end

      it 'returns left-wing sources if bias score is positive/right' do
        expect(bias_eliminator_right.filter_sources).to eq({independent: -20,
                                                           huffingtonpost: -40,
                                                           buzzfeed: -20,
                                                           morningstar: -60})
      end
    end

    context 'left-wing' do

      it 'checks if the bias_score is already_balanced?' do
        expect(bias_eliminator_left).to receive(:already_balanced?).and_return(false)
        bias_eliminator_left.filter_sources
      end

      # it 'selects the paper sources that have a bias rating between score_needed and 0' do
      #   expect(bias_eliminator_left).to receive(:papers).and_return({thetimes: 60,
      #                                                                express: 20,
      #                                                                bbc: 5})
      #   bias_eliminator_left.filter_sources
      # end

      it 'returns right-wing sources if bias score is negative/left' do
        expect(bias_eliminator_left.filter_sources).to eq({thetimes: 60,
                                                           express: 20,
                                                           bbc: 5})
      end
    end
  end
end
