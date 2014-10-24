require 'set'

Cell = Struct.new(:x, :y) do
  def neighbors
    (-1..1).flat_map do |i|
      (-1..1).map do |j|
        Cell.new(x+i, y+j)
      end
    end.to_set - [self]
  end
end
