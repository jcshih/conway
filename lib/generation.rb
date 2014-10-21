require 'set'

class Generation
  def initialize(cells, rules)
    @live_cells = Set.new(cells)
    @rules = rules
  end

  def population
    @live_cells.length
  end

  def tick
    Generation.new([], @rules)
  end
end
