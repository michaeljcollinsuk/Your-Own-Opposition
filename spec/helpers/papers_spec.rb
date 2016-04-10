require 'rails_helper'

describe Papers, :type => :class do
  subject(:papers) {described_class.new}
    describe '#initialize' do

      it 'has a hash of the papers we analyse with their political leaning scores' do
        expect(papers.list).to eq({dailymail: 100,
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
  end

end
