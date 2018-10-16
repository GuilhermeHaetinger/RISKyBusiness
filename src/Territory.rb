$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'
require './modules/constants'
require './buttons/TerritoryButton'
require './ui/MiniMenu'

class Territory
  def initialize(game, x, y)
    @button = TerritoryButton.new(game, self, x, y)
    @position = [x,y]
    @numOfTroops = 0
    @playerId = nil
    @game = game
    @miniMenu = MiniMenu.new(game, self, x, y)
    @showingMiniMenu = false
  end

  def getPlayerId()
    return @playerId
  end

  def getX()
    return @position[0]
  end

  def getY()
    return @position[1]
  end

  def getNumOfTroops()
    return @numOfTroops
  end

  def setPlayer(playerId)
    @playerId = playerId
  end

  def toggleMiniMenu()
    @showingMiniMenu = !@showingMiniMenu
    if @showingMiniMenu
      @game.hideOthersMiniMenus(self)
    end
  end

  def hideMiniMenu()
    @showingMiniMenu = false
  end

  def draw() 
    @button.draw()
    if @showingMiniMenu
      @miniMenu.draw()
    end
  end

  def clicked(id)
    if @game.playerTurn.getId() == @playerId
      @button.clicked(id)
    end
  end

  def increaseTroops(amount)
    @numOfTroops += amount
  end

  def decreaseTroops(amount)
    @numOfTroops -= amount
  end

  def setActiveImage(img)
    @button.setActiveImage(img)
  end
end