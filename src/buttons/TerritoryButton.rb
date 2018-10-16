$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'
require './modules/constants'

class TerritoryButton < Button
  def initialize(game, territory, x, y)
    super(game.getMain(), Gosu::Image.new('../assets/img/player1_troops.png', false), x, y, ZOrder::SPRITES, 
      method(:callback))
    @font = Gosu::Font.new(40)
    @game = game
    @territory = territory
  end

  def draw() 
    @font.draw_text("#{@territory.getNumOfTroops()}", @territory.getX()+15, @territory.getY()+15, ZOrder::SPRITES, 1.0, 1.0, Gosu::Color::YELLOW)
    super()
  end

  def handleOrganizePhase(id)
    if id == Gosu::MsLeft && @game.playerTurn.getTroopsAvailable() > 0
      @territory.increaseTroops(1)
      @game.playerTurn.decreaseTroops(1)
    elsif id == Gosu::MsRight && @territory.getNumOfTroops() > 0
      @territory.decreaseTroops(1)
      @game.playerTurn.increaseTroops(1)
    end
  end

  def handleNormalPhase(id)
    @territory.toggleMiniMenu()
  end

  def callback (id)
    if @game.getState() == Constants::ORGANIZE_PHASE
      self.handleOrganizePhase(id)
    elsif @game.getState() == Constants::NORMAL_PHASE
      self.handleNormalPhase(id)
    end
  end
end