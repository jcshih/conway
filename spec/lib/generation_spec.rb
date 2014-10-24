require 'set'
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

describe "still lifes" do
  it "block" do
    block = Set.new([Cell.new(4, 4), Cell.new(5, 4),
                     Cell.new(4, 5), Cell.new(5, 5)])
    gen = Generation.new(block)
    expect(gen.tick.live_cells).to eq(block)
  end

  it "beehive" do
    beehive = Set.new([Cell.new(3, 3), Cell.new(4, 3),
                       Cell.new(2, 4), Cell.new(5, 4),
                       Cell.new(3, 5), Cell.new(4, 5)])
    gen = Generation.new(beehive)
    expect(gen.tick.live_cells).to eq(beehive)
  end
end

describe "oscillators" do
  it "blinker" do
    blinker0 = Set.new([Cell.new(1, 1), Cell.new(1, 2), Cell.new(1, 3)])
    blinker1 = Set.new([Cell.new(0, 2), Cell.new(1, 2), Cell.new(2, 2)])

    gen0 = Generation.new(blinker0)
    gen1 = gen0.tick
    gen2 = gen1.tick

    expect(gen1.live_cells).to eq(blinker1)
    expect(gen2.live_cells).to eq(blinker0)
  end

  it "beacon" do
    beacon0 = Set.new([Cell.new(1, 1), Cell.new(2, 1), Cell.new(1, 2),
                       Cell.new(2, 2), Cell.new(3, 3),
                       Cell.new(4, 3), Cell.new(3, 4), Cell.new(4, 4)])
    beacon1 = Set.new([Cell.new(1, 1), Cell.new(2, 1), Cell.new(1, 2),
                       Cell.new(4, 3), Cell.new(3, 4), Cell.new(4, 4)])

    gen0 = Generation.new(beacon0)
    gen1 = gen0.tick
    gen2 = gen1.tick

    expect(gen1.live_cells).to eq(beacon1)
    expect(gen2.live_cells).to eq(beacon0)
  end
end

describe "spaceships" do
  it "glider" do
    glider0 = Set.new([Cell.new(1, 1), Cell.new(2, 2), Cell.new(0, 3),
                       Cell.new(1, 3), Cell.new(2, 3)])
    glider1 = Set.new([Cell.new(0, 2), Cell.new(2, 2), Cell.new(1, 3),
                       Cell.new(2, 3), Cell.new(1, 4)])
    glider2 = Set.new([Cell.new(2, 2), Cell.new(0, 3), Cell.new(2, 3),
                       Cell.new(1, 4), Cell.new(2, 4)])
    glider3 = Set.new([Cell.new(1, 2), Cell.new(2, 3), Cell.new(3, 3),
                       Cell.new(1, 4), Cell.new(2, 4)])

    gen0 = Generation.new(glider0)
    gen1 = gen0.tick
    gen2 = gen1.tick
    gen3 = gen2.tick

    expect(gen1.live_cells).to eq(glider1)
    expect(gen2.live_cells).to eq(glider2)
    expect(gen3.live_cells).to eq(glider3)
  end
end
