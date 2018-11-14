$LOAD_PATH << '.'

require './modules/constants'


class Cursor
  def initialize (window)
    @window = window
    @img = Gosu::Image.new("../assets/img/cursor.png", false)
  end

  def draw
    @img.draw(@window.mouse_x, @window.mouse_y, ZOrder::CURSOR)
  end
end
