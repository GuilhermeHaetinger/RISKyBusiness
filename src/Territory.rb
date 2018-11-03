$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'
require './modules/constants'
require './buttons/TerritoryButton'

class Territory
  def initialize(game, t_name,  x, y)
    @button = TerritoryButton.new(game, self, x, y)
    @name = t_name
    @position = [x,y]
    @numOfTroops = 1
    @numOfTroopsOnRound = 1
    @numOfRemanaged = 0
    @playerId = nil
    @game = game
    @adjacentTerritories = Array.new
  end

  def getName()
    @name
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

  # Objective 1
  # Objective 6
  def updateAdjacentTerritories(territories)
    territories.reduce(@adjacentTerritories) { |newAdjacentTerritories, territory|
      newAdjacentTerritories.push(territory) }
  end

  def setAdjacentTerritories(territories)
    @adjacentTerritories = updateAdjacentTerritories(territories)
  end

  def draw() 
    @button.draw()
  end

  def clicked(id)
    if @game.playerTurn.getId() == @playerId or @game.getState() == Constants::ATTACK
      @button.clicked(id)
    end
  end
  # Objective 5
  def changeTroops(fn, amount)
    @numOfTroops = @numOfTroops.send(fn, amount)
  end

  def setActiveImage(img)
    @button.setActiveImage(img)
  end

  def setMainImage(img)
    @button.changeMainImage(img)
  end

  def setAsAttackable()
    @button.setAsAttackable()
  end
  
  def setAsMovable()
    @button.setAsMovable()
  end
  
  def returnToNormalState()
    @button.returnToMainImage()
  end

  def areThereEnemiesAdjacent()
    getAdjacentTerritories().each do |territory|
      if territory.getPlayerId() != self.getPlayerId()
        return true
      end
    end
    return false
  end

  def areThereAlliesAdjacent()
    getAdjacentTerritories().each do |territory|
      if territory.getPlayerId() == self.getPlayerId()
        return true
      end
    end
    return false
  end

  def updateRoundTroops()
    @numOfTroopsOnRound = @numOfTroops
  end

  def getRoundTroops()
    @numOfTroopsOnRound
  end

  def increaseRemanagedTroops()
    @numOfRemanaged += 1
  end

  def decreaseRemanagedTroops()
    @numOfRemanaged -= 1
  end

  def resetRemanagedTroops()
    @numOfRemanaged = 0
  end

  def getRemanagedTroops()
    @numOfRemanaged
  end

end