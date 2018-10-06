$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'

class Territory < Button
  def initialize(game, x, y)
    super(game.getWindow(), Gosu::Image.new('../assets/img/player1_troops.png', false), x, y, ZOrder::SPRITES, 
      lambda{ self.callback })
    @position = [x,y]
    @numOfTroops = 0
    @playerId = nil
    @font = Gosu::Font.new(40)
    @game = game
  end

  def setPlayer(playerId)
    @playerId = playerId
  end

  def draw() 
    @font.draw_text("#{@numOfTroops}", @position[0]+15, @position[1]+15, ZOrder::SPRITES, 1.0, 1.0, Gosu::Color::YELLOW)
    super()
  end

  def callback ()
    if @game.playerTurn.getId() == @playerId && @game.playerTurn.getTroopsAvailable() > 0
      @numOfTroops+=1
      @game.playerTurn.decreaseTroops()
    end
  end
end