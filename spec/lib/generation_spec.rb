require 'generation'
require 'cell'

describe Generation do
  describe "#candidate_dead_cells" do
    it "gets correct candidates for overlapping neighbors" do
      gen = Generation.new([Cell.new(0, 0), Cell.new(1, 1)])
      expect(gen.candidate_dead_cells.length).to eq(12)
    end
  end

  describe "#cells_stay_alive" do
    it "returns correct survivor" do
      gen = Generation.new([Cell.new(3, 3), Cell.new(3, 4), Cell.new(4, 5)])
      expect(gen.cells_stay_alive).to eq(Set.new([Cell.new(3, 4)]))
    end
  end

  describe "#cells_come_alive" do
    it "returns correct birth" do
      gen = Generation.new([Cell.new(6, 3), Cell.new(7, 4), Cell.new(6, 5)])
      expect(gen.cells_come_alive).to eq(Set.new([Cell.new(6, 4)]))
    end
  end
end

describe "still life" do
end

describe "oscillator" do
end

describe "glider" do
end
