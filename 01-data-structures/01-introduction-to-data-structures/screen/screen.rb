require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    @width = width
    @height = height
    @matrix = {}
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    if !existing_coor(x, y) && inbounds(x, y)
      @matrix[[x, y]] = pixel
    end
  end

  def at(x, y)
    @matrix[[x, y]]
  end

  private

  def inbounds(x, y)
    x >= 0 && y >= 0
  end

  def existing_coor(x, y)
    @matrix.keys.include?([x, y])
  end
end
