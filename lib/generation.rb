require 'set'

class Generation
  def initialize(cells)
    @live_cells = Set.new(cells)
  end

  def population
    @live_cells.length
  end

  def tick
    Generation.new([])
  end
end
