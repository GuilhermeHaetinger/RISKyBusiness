$LOAD_PATH << '.'
require './modules/constants'
require 'Territory'
require './ui/Ui'
require 'Player'
class Game
  def initialize (main)
    @main = main
    @buttons = Array.new
    @background_image = Gosu::Image.new(
      "../assets/img/MAP.jpg", 
      tileable: true
    )
    @player1 = Player.new('player1', 0)
    @player2 = Player.new('player2', 1)
    @ui = Ui.new(main, @player1, @player2)
    @territories = Array.new
    @playerTurn = @player1
    @state = Constants::ORGANIZE_PHASE
    self.initTerritories()
    self.randTerritories()
  end

  def changeTurn()
    if @playerTurn.getId() == @player1.getId()
      @playerTurn = @player2
    else
      @playerTurn = @player1
    end
  end

  def initTerritories()
    # TODO Needs to be refactored :D 
    # Creating territories
    chile             = Territory.new(self, "Chile", 211, 478) # Chile
    venezuela         = Territory.new(self, "Venezuela", 254, 393) # Venezuela
    argentina         = Territory.new(self, "Argentina", 286, 592) # Argentina
    brazil            = Territory.new(self, "Brazil", 399, 481) # Brazil
    north_africa      = Territory.new(self, "North Africa", 502, 390) # North Africa
    south_africa      = Territory.new(self, "South Africa", 588, 617) # South Africa
    central_africa    = Territory.new(self, "Central Africa", 606, 495) # Central Africa
    northeast_africa  = Territory.new(self, "Northeast Africa", 633, 362) # Northeast Africa
    east_africa       = Territory.new(self, "East Africa", 702, 463) # East Africa
    madagascar        = Territory.new(self, "Madagascar", 712, 580) # Madagascar
    
    # Setting adjacent territories
    adjacents1 = Array[venezuela, argentina, brazil]
    chile.setAdjacentTerritories(adjacents1)
    
    adjacents2 = Array[chile, brazil]
    venezuela.setAdjacentTerritories(adjacents2)

    adjacents3 = Array[chile, brazil]
    argentina.setAdjacentTerritories(adjacents3)

    adjacents4 = Array[chile, venezuela, argentina]
    brazil.setAdjacentTerritories(adjacents4)

    adjacents5 = Array[central_africa, northeast_africa, east_africa]
    north_africa.setAdjacentTerritories(adjacents5)

    adjacents6 = Array[madagascar, central_africa, east_africa]
    south_africa.setAdjacentTerritories(adjacents6)

    adjacents7 = Array[north_africa, east_africa, south_africa]
    central_africa.setAdjacentTerritories(adjacents7)

    adjacents8 = Array[east_africa, north_africa]
    northeast_africa.setAdjacentTerritories(adjacents8)

    adjacents9 = Array[central_africa, north_africa, northeast_africa, south_africa]
    east_africa.setAdjacentTerritories(adjacents9)

    adjacents10 = Array[south_africa]
    madagascar.setAdjacentTerritories(adjacents10)

    @territories.push(chile) # Chile
    @territories.push(venezuela) # Venezuela
    @territories.push(argentina) # Argentina
    @territories.push(brazil) # Brazil
    @territories.push(north_africa) # North Africa
    @territories.push(south_africa) # South Africa
    @territories.push(central_africa) # Central Africa
    @territories.push(northeast_africa) # Northeast Africa
    @territories.push(east_africa) # East Africa
    @territories.push(madagascar) # Madagascar
  end

  def randTerritories()
    @territories.each_with_index do |territory, index|
      if index % 2 == 0
        territory.setPlayer(@player1.getId())
        territory.setActiveImage(Gosu::Image.new('../assets/img/player2_troops.png', false))
      else
        territory.setPlayer(@player2.getId())
        territory.setActiveImage(Gosu::Image.new('../assets/img/player1_troops.png', false))
      end
    end
  end

  def getMain()
    return @main
  end

  def getState()
    return @state
  end

  def playerTurn()
    @playerTurn
  end

  def add_button (button)
    @buttons.push(button)
    @main
  end

  def hideOthersMiniMenus(argTerritory)
    @territories.each do |territory| 
      if territory != argTerritory
        territory.hideMiniMenu()
      end
    end
  end

  def draw ()
    @ui.draw()
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @territories.each do |territory| 
      territory.draw()
    end
    @buttons.each do |i|
      i.draw()
    end
  end

  def update ()
    @ui.update()
    @territories.each do |territory| 
      territory.update()
    end
    @buttons.each do |i|
      i.update()
    end
  end

  def clicked (id)
    @territories.each do |territory| 
      territory.clicked(id)
    end
    @buttons.each do |i|
        i.clicked(id)
    end
  end

  def handleOrganizePhase()
    if self.organizePhaseEnded()
      @state = Constants::NORMAL_PHASE
    else
      self.changeTurn()
    end
  end

  def handleNormalPhase()
    self.changeTurn()
  end

  def pressedKey(id)
    if id == Gosu::KB_RETURN && @state == Constants::ORGANIZE_PHASE
      self.handleOrganizePhase()
    elsif id == Gosu::KB_RETURN && @state == Constants::NORMAL_PHASE
      self.handleNormalPhase()
    elsif id == Gosu::KB_ESCAPE
      @main.setOnGame(false)
      @main.setOnMenu(true)
    end
  end

  def organizePhaseEnded()
    @territories.each do |territory|
      if territory.getNumOfTroops() == Constants::EMPTY
        return false
      end
    end
    if @player1.getTroopsAvailable() == 0 && @player2.getTroopsAvailable() == 0
      return true
    end
    return false
  end
end