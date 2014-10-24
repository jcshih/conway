require 'cell'
require 'set'

describe 'coordinates' do
  let(:cell) { Cell.new(1,2) }

  it 'has x coordinate' do
    expect(cell.x).to eq(1)
  end

  it 'has y coordinate' do
    expect(cell.y).to eq(2)
  end
end

describe 'set behavior' do
  let(:cell1) { Cell.new(1,2) }
  let(:cell2) { Cell.new(3,4) }

  it 'treats like-valued cells as equal' do
    set1 = [cell1, cell1, cell2].to_set
    set2 = [cell1, cell2].to_set
    expect(set1).to eq(set2)
  end
end

describe 'neighbor' do
  let(:cell) { Cell.new(5,6) }
  let(:neighbors) { cell.neighbors }

  it 'numbers 8 per cell' do
    expect(neighbors.length).to eq(8)
  end

  it 'is within range of cell' do
    x, y = cell.x, cell.y
    neighbors.each do |n|
      expect(n.x.between?(x-1, x+1)).to eq(true)
      expect(n.y.between?(y-1, y+1)).to eq(true)
    end
  end
end
