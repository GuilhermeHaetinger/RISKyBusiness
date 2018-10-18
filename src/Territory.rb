$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'
require './modules/constants'
require './buttons/TerritoryButton'
require './ui/MiniMenu'

class Territory
  def initialize(game, t_name,  x, y)
    @button = TerritoryButton.new(game, self, x, y)
    @name = t_name
    @position = [x,y]
    @numOfTroops = 1
    @playerId = nil
    @game = game
    @miniMenu = MiniMenu.new(game, self, x, y)
    @showingMiniMenu = false
    @adjacentTerritories = Array.new
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

  def getAdjacentTerritories()
    return @adjacentTerritories
  end

  def setPlayer(playerId)
    @playerId = playerId
  end

  def setAdjacentTerritories(territories)
    for territory in territories
      @adjacentTerritories.push(territory)
    end
  end

  # def toggleMiniMenu()
  #   if @numOfTroops > 1 or @showingMiniMenu
  #     @showingMiniMenu = !@showingMiniMenu
  #   end
  #   if @showingMiniMenu
  #     @game.hideOthersMiniMenus(self)
  #   end
  # end

  # def hideMiniMenu()
  #   @showingMiniMenu = false
  # end

  def draw() 
    @button.draw()
    # if @showingMiniMenu
    #   @miniMenu.draw()
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