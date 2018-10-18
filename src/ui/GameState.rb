$LOAD_PATH << '.'

require './modules/zorder'

class GameState
  def initialize(game)
    @game = game
    @text = "START!"
    @subtext = "press <Enter> when ready"
    @h1 = Gosu::Font.new(45)
    @p = Gosu::Font.new(30)
  end

  def update(text)
    if text.length == 0
        @subtext = "press <Enter> when ready"
    else
        @subtext = text
    end

    if @game.getState == Constants::ORGANIZE_PHASE
        @text = "START!"
    elsif @game.getState == Constants::TROOP_PLACEMENT
        @text = "REINFORCE!"
    elsif @game.getState == Constants::ATTACK
        @text = "ATTACK!"
    elsif @game.getState == Constants::VICTORY_MANAGEMENT
        @text = "CONQUER!"
    elsif @game.getState == Constants::MANAGEMENT
        @text = "REMANAGE!"
    end
  end

  def draw()
    @h1.draw_text("#{@text}", 20, 600, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
    @p.draw_text("#{@subtext}", 900, 675, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
  end


end