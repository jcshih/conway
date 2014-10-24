require 'set'
require 'rules'

class Generation
  include Rules

  attr_reader :live_cells

  def initialize(cells)
    @live_cells = Set.new(cells)
  end

  def population
    @live_cells.length
  end

  def tick
    Generation.new(live_cells_next)
  end

  def live_cells_next
    cells_stay_alive + cells_come_alive
  end

  def cells_stay_alive
    candidate_live_cells.find_all do |c|
      stays_alive?(c.neighbors & candidate_live_cells)
    end.to_set
  end

  def cells_come_alive
    candidate_dead_cells.find_all do |c|
      comes_alive?(c.neighbors & candidate_live_cells)
    end.to_set
  end

  def candidate_live_cells
    @live_cells
  end

  def candidate_dead_cells
    @live_cells.flat_map do |c|
      c.neighbors
    end.reduce(:+) - @live_cells
  end
end
