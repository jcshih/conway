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
