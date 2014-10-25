$LOAD_PATH.unshift File.expand_path('../../', __FILE__)

require 'set'
require 'gosu'
require 'cell'
require 'generation'

class GOL < Gosu::Window
  BGCOLOR = Gosu::Color::BLACK
  LIVECOLOR = Gosu::Color::RED
  DEADCOLOR = Gosu::Color::WHITE

  CELLSIZE = 10

  def initialize(size, points)
    @size = size
    @length = @size * CELLSIZE
    super @length, @length, false, 500

    @gen = Generation.new(seed(points))
    @gen_num = 0
    self.caption = "Generation #{@gen_num}"
  end

  def seed(points)
    points.map do |p|
      Cell.new(*p.split(',').map(&:to_i))
    end.to_set
  end

  def filter_cells_outside_range
    @gen.live_cells.select do |c|
      c.x.between?(0, @size-1) && c.y.between?(0, @size-1)
    end
  end

  def update
    @gen = @gen.tick
    @gen_num += 1
    self.caption = "Generation #{@gen_num}"
  end

  def draw
    draw_background
    draw_cells
    draw_live_cells
  end

  def draw_background
    draw_quad(
      0,        0,        BGCOLOR,
      @length,  0,        BGCOLOR,
      0,        @length,  BGCOLOR,
      @length,  @length,  BGCOLOR
    )
  end

  def draw_cells
    (0..@size-1).each do |x|
      (0..@size-1).each do |y|
        draw_cell(x, y, DEADCOLOR)
      end
    end
  end

  def draw_live_cells
    filter_cells_outside_range.each do |c|
      draw_cell(c.x, c.y, LIVECOLOR)
    end
  end

  def draw_cell(x, y, color)
    draw_quad(
      x*CELLSIZE,       y*CELLSIZE,       color,
      (x+1)*CELLSIZE-1, y*CELLSIZE,       color,
      x*CELLSIZE,       (y+1)*CELLSIZE-1, color,
      (x+1)*CELLSIZE-1, (y+1)*CELLSIZE-1, color
    )
  end
end

class GosuPlayer
  def initialize(size, points)
    @window = GOL.new(size, points)
  end

  def run
    @window.show
  end
end
