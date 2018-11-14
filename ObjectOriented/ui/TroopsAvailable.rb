$LOAD_PATH << '.'

require './modules/zorder'

class TroopsAvailable
  def initialize(player, x, y)
    @player = player
    @x = x
    @y = y
    @h1 = Gosu::Font.new(50)
    @p = Gosu::Font.new(35)
    @color = Gosu::Color::GREEN
  end

  def update(turn)
    if turn
      @h1 = Gosu::Font.new(50)
      @p = Gosu::Font.new(35)
      @color = Gosu::Color::GREEN
    else
      @h1 = Gosu::Font.new(40)
      @p = Gosu::Font.new(25)
      @color = Gosu::Color::GRAY
    end
  end

  def draw()
    @h1.draw_text("Troops Available", @x, @y, ZOrder::UI, 1.0, 1.0, @color)
    @p.draw_text("#{@player.getName()} -- #{@player.getTroopsAvailable()}", @x, @y+50, ZOrder::UI, 1.0, 1.0, @color)
  end


end