require 'generation'

describe Generation do
  let(:rules) { double("rules") }

  context 'empty' do
    let(:gen) { Generation.new([], rules) }

    it 'calls .stays_alive? 0 times' do
      allow(rules).to receive(:stays_alive?) { rules }
      gen.tick
      expect(rules).to receive(:stays_alive?).exactly(0).times
    end

    it 'calls .comes_alive? 0 times' do
      allow(rules).to receive(:comes_alive?) { rules }
      gen.tick
      expect(rules).to receive(:comes_alive?).exactly(0).times
    end
  end

  context '1 cell'

  context 'overlapping neighbor space'
end
