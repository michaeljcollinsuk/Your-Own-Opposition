require 'rails_helper'

describe BiasCalculator, :type => :class do
  let(:dummy_papers) {double :dummy_papers}
  let(:dummy_right_sources) {[:dailymail, :telegraph, :telegraph, :telegraph, :dailymail]}
  let(:dummy_left_sources) {[:theguardian, :thetimes, :bbc, :morningstar]}
  subject(:bias_calculator_klass) {described_class}

  subject(:bias_calculator_right) {described_class.new(dummy_right_sources)}
  subject(:bias_calculator_left) {described_class.new(dummy_left_sources)}
  subject(:bias_calculator) {described_class.new(dummy_right_sources)}

  before do
    allow(dummy_papers).to receive(:list)
                       .and_return({dailymail: 100,
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
  end

  describe 'on #initialize' do

    it 'calls #calculate_leaning with sources_read to find political_leaning' do
      expect_any_instance_of(bias_calculator_klass).to receive(:calculate_leaning)
      bias_calculator_right.political_leaning
    end

    it 'calls #match_bias_message to assign a humerous message to political_leaning' do
      expect_any_instance_of(bias_calculator_klass).to receive(:match_bias_message)
      bias_calculator_right.bias_message
    end

  end

  describe 'once #initialized' do

    it 'stores an array of the most recent sources read' do
      expect(bias_calculator_right.sources_read).to eq(dummy_right_sources)
    end

  end

  describe '#calculate_leaning' do

    before do
      allow(bias_calculator).to receive(:political_leaning_scores).and_return([100, -100])
      allow(bias_calculator).to receive(:sources_read).and_return([:dailymail, :theguardian])
    end

    it 'calls #political_leaning_scores to retrieve each papers political leaning' do
      expect(bias_calculator).to receive(:political_leaning_scores)
      bias_calculator.calculate_leaning
    end

    it 'calls length on #sources_read to find the divisor to calculate average' do
      expect(bias_calculator).to receive(:sources_read)
      bias_calculator.calculate_leaning
    end


    context 'right-wing sources read' do

      it 'returns a +ve score (out of 100) for right-wing political leniencies' do
        expect(bias_calculator_right.calculate_leaning).to be_between(0, 100).inclusive
      end
    end

    context 'left-wing sources read' do

      it 'returns a -ve score (out of 100) for left-wing political leniencies' do
        expect(bias_calculator_left.calculate_leaning).to be_between(-100, 0).inclusive
      end
    end
  end

  describe '#match_bias_message' do
    let(:dummy_messages) {double :dummy_messages}

    before do
      allow(dummy_messages).to receive(:list)
                           .and_return({-100..-80 => :"Corbynista Commie",
                                        -80..-50 => :"#FeelTheBern Bernista",
                                        -50..-20 => :"Un-washed Hippie Bastard",
                                        -10..-20 => :"Loony Left Leaner",
                                        -10..10 => :"Fence Sitter",
                                        10..20 => :"I'm not Racist but...",
                                        20..50 => :"Benefit-Scrounger Blamer",
                                        50..80 => :"Cameron is Peppa Pig's Best Friend",
                                        80..100 => :"Trump-Loving Bum-Trumpet"})
    end

    context 'right-wing political_leanings' do

      it 'returns a humerous message based on political_leaning of 15' do
        allow(bias_calculator).to receive(:political_leaning).and_return(15)
        expect(bias_calculator.match_bias_message).to eq(:"I'm not Racist but...")
      end

      it 'returns a humerous message based on political_leaning of 30' do
        allow(bias_calculator).to receive(:political_leaning).and_return(30)
        expect(bias_calculator.match_bias_message).to eq(:"Benefit-Scrounger Blamer")
      end

      it 'returns a humerous message based on political_leaning of 60' do
        allow(bias_calculator).to receive(:political_leaning).and_return(60)
        expect(bias_calculator.match_bias_message).to eq(:"Cameron is Peppa Pig's Best Friend")
      end

      it 'returns a humerous message based on political_leaning of 90' do
        allow(bias_calculator).to receive(:political_leaning).and_return(90)
        expect(bias_calculator.match_bias_message).to eq(:"Trump-Loving Bum-Trumpet")
      end

    end

    context 'left-wing political_leanings' do

      it 'returns a humerous message based on political_leaning of 90' do
        allow(bias_calculator).to receive(:political_leaning).and_return(-90)
        expect(bias_calculator.match_bias_message).to eq(:"Corbynista Commie")
      end

      it 'returns a humerous message based on political_leaning of 90' do
        allow(bias_calculator).to receive(:political_leaning).and_return(-60)
        expect(bias_calculator.match_bias_message).to eq(:"#FeelTheBern Bernista")
      end

      it 'returns a humerous message based on political_leaning of 90' do
        allow(bias_calculator).to receive(:political_leaning).and_return(-30)
        expect(bias_calculator.match_bias_message).to eq(:"Un-washed Hippie Bastard")
      end

      it 'returns a humerous message based on political_leaning of 90' do
        allow(bias_calculator).to receive(:political_leaning).and_return(-15)
        expect(bias_calculator.match_bias_message).to eq(:"Loony Left Leaner")
      end

      it 'returns a humerous message based on political_leaning of 90' do
        allow(bias_calculator).to receive(:political_leaning).and_return(-5)
        expect(bias_calculator.match_bias_message).to eq(:"Fence Sitter")
      end
    end
  end
end
