$LOAD_PATH.unshift File.expand_path('../../', __FILE__)

require 'set'
require 'dispel'
require 'cell'
require 'generation'

class Ascii
  def initialize(size, points)
    @size = size
    @gen = Generation.new(seed(points))
    @gen_num = 0
  end

  def seed(points)
    points.map do |p|
      Cell.new(*p.split(',').map(&:to_i))
    end.to_set
  end

  def grid
    @size.times.map { "|_"*@size+"|\n" }.join
  end

  def world
    plot = grid
    filter_cells_outside_range.each do |c|
      plot[c.y*(2*@size+2)+c.x*2+1] = "*"
    end
    plot
  end

  def filter_cells_outside_range
    @gen.live_cells.select do |c|
      c.x.between?(0, @size-1) && c.y.between?(0, @size-1)
    end
  end

  def status
    " Generation #{@gen_num}\n"
  end

  def instructions
    "Press q to quit"
  end

  def output
    status+world+instructions
  end

  def tick
    @gen = @gen.tick
    @gen_num += 1
  end

  def run
    Dispel::Screen.open do |screen|
      screen.draw output

      Dispel::Keyboard.output :timeout => 0.5 do |key|
        break if key == "q"
        if key == :timeout
          tick
          screen.draw output
        end
      end
    end
  end
end
