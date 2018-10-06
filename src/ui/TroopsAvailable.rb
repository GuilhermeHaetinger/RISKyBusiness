$LOAD_PATH << '.'

require './modules/zorder'

class TroopsAvailable
  def initialize(player, x, y)
    @player = player
    @x = x
    @y = y
    @h1 = Gosu::Font.new(50)
    @p = Gosu::Font.new(35)
  end

  def update()
  end

  def draw()
    @h1.draw_text("Troops Available", @x, @y, ZOrder::UI, 1.0, 1.0, Gosu::Color::GREEN)
    @p.draw_text("#{@player.getName()} -- #{@player.getTroopsAvailable()}", @x, @y+50, ZOrder::UI, 1.0, 1.0, Gosu::Color::GREEN)
  end


end