require 'rules'

describe Rules do
  before(:context) do
    @rules = Class.new
    @rules.extend(Rules)
  end
  let(:cell) { double("Cell") }

  context 'live cell' do
    it 'dies of underpopulation' do
      allow(cell).to receive("neighbors").and_return([double])
      expect(@rules.stays_alive?(cell.neighbors)).to eq(false)
    end

    it 'survives' do
      allow(cell).to receive("neighbors").and_return([double]*2)
      expect(@rules.stays_alive?(cell.neighbors)).to eq(true)
    end

    it 'dies of overcrowding' do
      allow(cell).to receive("neighbors").and_return([double]*4)
      expect(@rules.stays_alive?(cell.neighbors)).to eq(false)
    end
  end

  context 'dead cell' do
    it 'comes alive by reproduction' do
      allow(cell).to receive("neighbors").and_return([double]*3)
      expect(@rules.comes_alive?(cell.neighbors)).to eq(true)
    end

    it 'stays dead otherwise' do
      allow(cell).to receive("neighbors").and_return([], [double]*6)
      expect(@rules.comes_alive?(cell.neighbors)).to eq(false)
      expect(@rules.comes_alive?(cell.neighbors)).to eq(false)
    end
  end
end