$LOAD_PATH << '.'

require './modules/zorder'

class Score
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @h1 = Gosu::Font.new(50)
    @p = Gosu::Font.new(35)
  end

  def update()
  end

  def draw()
    @h1.draw_text("Name -- Score", 10, 550, ZOrder::UI, 1.0, 1.0, Gosu::Color::CYAN)
    @p.draw_text("#{@player1.getName()} -- #{@player1.getScore()}", 10, 600, ZOrder::UI, 1.0, 1.0, Gosu::Color::CYAN)
    @p.draw_text("#{@player2.getName()} -- #{@player2.getScore()}", 10, 650, ZOrder::UI, 1.0, 1.0, Gosu::Color::CYAN)
  end


end