require 'rails_helper'

describe MediaDiet, :type => :class do
  let(:topics) {[:brexit, :cameron, :cameron, :brexit, :EU, :cameron]}
  let(:sources) {[:dailymail, :dailymail, :guardian, :dailymail, :buzzfeed]}
  let(:bias_calculator_klass) {double :bias_calculator_klass}
  let(:bias_calculator) {double :bias_calculator}
  subject(:media_diet_topics) {described_class.new(topics)}
  subject(:media_diet_sources) {described_class.new(sources)}


  describe '#initialize' do

    it 'is initialized with an empty media diet hash' do
      expect(media_diet_topics.composition).to eq(Hash.new)
    end

    it 'stores an array of (sources or) topics to analyse in diet_components' do
      expect(media_diet_topics.components).to eq(topics)
    end

    it 'stores an array of sources (or topics) to analyse in diet_components' do
      expect(media_diet_sources.components).to eq(sources)
    end
  end

  describe '#analyse_composition' do

    it 'fills media_diet hash with keywords matched to percentage of diet' do
      media_diet_sources.analyse_composition
      expect(media_diet_sources.composition).to eq({:dailymail => 60, :guardian => 20, :buzzfeed => 20})
    end

    it 'fills media_diet hash with keywords matched to percentage of diet' do
      media_diet_topics.analyse_composition
      expect(media_diet_topics.composition).to eq({:cameron => 50, :brexit => 33, :EU => 16})
    end
  end

  describe '#current_bias' do

    before do
      allow(bias_calculator_klass).to receive(:new).and_return(bias_calculator)
    end

    it 'instantiates a new instance of BiasCalculator with media diet components' do
      expect(bias_calculator_klass).to receive(:new).with(media_diet_sources.components)
      media_diet_sources.current_bias(bias_calculator_klass)
    end
  end
end
