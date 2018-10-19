$LOAD_PATH << '.'
require './modules/constants'
require 'Territory'
require './ui/Ui'
require 'Player'
require 'Continent'
require 'Dice'
require 'TerritoryObjective'
require 'ConquerObjective'

class Game
  def initialize (main)
    @main = main
    @buttons = Array.new
    @background_image = Gosu::Image.new(
      "../assets/img/MAP.jpg", 
      tileable: true
    )
    @territories = Array.new
    @continents = Array.new
    @objectives = Array.new
    @state = Constants::SHOWING_OBJECTIVES
    @preSelectedTerritory = nil
    @conquest = nil #Battle 
    self.initTerritories()
    self.initObjectives()
    player1objective = rand(@objectives.length)
    player2objective = player1objective
    loop do
      player2objective = rand(@objectives.length)
      break if player2objective != player1objective
    end
    @player1 = Player.new('player1', 0, @objectives[player1objective])
    @player2 = Player.new('player2', 1, @objectives[player2objective])
    @ui = Ui.new(self, main, @player1, @player2)
    @playerTurn = @player1
    self.randTerritories()
    @hasSeenObj1 = false
    @hasSeenWarning2 = false
    @hasSeenObj2 = false
    @ui.update("Player 2 close your eyes!")
  end

  def changeTurn()
    if @playerTurn.getId() == @player1.getId()
      @playerTurn = @player2
    else
      @playerTurn = @player1
    end
    @ui.update()
  end

  def initTerritories()
    # TODO Needs to be refactored :D 
    # Creating territories
    chile             = Territory.new(self, "Chile", 211, 478) # Chile
    venezuela         = Territory.new(self, "Venezuela", 254, 393) # Venezuela
    argentina         = Territory.new(self, "Argentina", 286, 592) # Argentina
    brazil            = Territory.new(self, "Brazil", 399, 481) # Brazil
    
    mexico            = Territory.new(self, "Mexico", 200, 320) # Mexico
    easternUS         = Territory.new(self, "Eastern US", 270, 250) # Eastern US
    westernUS         = Territory.new(self, "Western US", 170, 235) # Western US
    quebec            = Territory.new(self, "Quebec", 350, 180) # Quebec
    ontario           = Territory.new(self, "Ontario", 275, 170) # Ontario
    alberta           = Territory.new(self, "Alberta", 180, 160) # Alberta
    alaska            = Territory.new(self, "Alaska", 50, 100) # Alaska
    northwest         = Territory.new(self, "Northwest Territory", 170, 90) # Northwest Territory
    greenland         = Territory.new(self, "Greenland", 470, 55) # Greenland
 
    iceland           = Territory.new(self, "Iceland", 500, 120) # Iceland
    britain           = Territory.new(self, "Britain", 485, 200) # Britain
    westernEU         = Territory.new(self, "Western EU", 475, 270) # Western EU
    northEU           = Territory.new(self, "North EU", 570, 210) # North EU
    southEU           = Territory.new(self, "South EU", 590, 280) # South EU
    scandinavia       = Territory.new(self, "Scandinavia", 600, 100) # Scandinavia
    ukraine           = Territory.new(self, "Ukraine", 690, 150) # Ukraine
 
    afghanistan       = Territory.new(self, "Afghanistan", 795, 235) # Afghanistan
    ural              = Territory.new(self, "Ural", 810, 130) # Ural
    siberia           = Territory.new(self, "Siberia", 900, 110) # Siberia
    yakursk           = Territory.new(self, "Yakursk", 1025, 100) # Yakursk
    kamtchatka        = Territory.new(self, "Kamtchatka", 1150, 110) # Kamtchatka
    irkutsk           = Territory.new(self, "Irkutsk", 990, 170) # Irkutsk
    mongolia          = Territory.new(self, "Mongolia", 1020, 230) # Mongolia
    japan             = Territory.new(self, "Japan", 1100, 250) # Japan
    china             = Territory.new(self, "China", 920, 280) # China
    middleEast        = Territory.new(self, "Middle", 725, 350) # Middle East
    india             = Territory.new(self, "India", 850, 390) # India
    siam              = Territory.new(self, "Siam", 950, 370) # Siam
 
    indonesia         = Territory.new(self, "Indonesia", 920, 460) # Indonesia
    newGuinea         = Territory.new(self, "New Guinea", 1150, 480) # New Guinea
    eastAustralia     = Territory.new(self, "Eastern Australia", 1100, 550) # Eastern Australia
    westAustralia     = Territory.new(self, "Western Australia", 970, 580) # Western Australia

    north_africa      = Territory.new(self, "North Africa", 502, 390) # North Africa
    south_africa      = Territory.new(self, "South Africa", 588, 617) # South Africa
    central_africa    = Territory.new(self, "Central Africa", 606, 495) # Central Africa
    egypt             = Territory.new(self, "Egypt", 633, 362) # Egypt
    east_africa       = Territory.new(self, "East Africa", 702, 463) # East Africa
    madagascar        = Territory.new(self, "Madagascar", 712, 580) # Madagascar

    # Setting adjacent territories
    chile.setAdjacentTerritories(Array[venezuela, argentina, brazil])
    
    venezuela.setAdjacentTerritories(Array[chile, brazil, mexico])

    argentina.setAdjacentTerritories(Array[chile, brazil])

    brazil.setAdjacentTerritories(Array[chile, venezuela, argentina])

    north_africa.setAdjacentTerritories(Array[central_africa, egypt, east_africa, westernEU, southEU])

    south_africa.setAdjacentTerritories(Array[madagascar, central_africa, east_africa])

    central_africa.setAdjacentTerritories(Array[north_africa, east_africa, south_africa])

    egypt.setAdjacentTerritories(Array[east_africa, north_africa, southEU, middleEast])

    east_africa.setAdjacentTerritories(Array[central_africa, north_africa, egypt, south_africa])

    madagascar.setAdjacentTerritories(Array[south_africa])

    mexico.setAdjacentTerritories(Array[venezuela, westernUS, easternUS])

    westernUS.setAdjacentTerritories(Array[easternUS, mexico, alberta, ontario])

    easternUS.setAdjacentTerritories(Array[westernUS, mexico, ontario, quebec])

    alberta.setAdjacentTerritories(Array[westernUS, ontario, northwest, alaska])

    ontario.setAdjacentTerritories(Array[westernUS, easternUS, alberta, northwest, quebec, greenland])

    quebec.setAdjacentTerritories(Array[easternUS, ontario, greenland])

    alaska.setAdjacentTerritories(Array[northwest, alberta, kamtchatka])

    northwest.setAdjacentTerritories(Array[alaska, alberta, ontario, greenland])

    greenland.setAdjacentTerritories(Array[northwest, quebec, iceland])

    iceland.setAdjacentTerritories(Array[greenland, britain, scandinavia])

    britain.setAdjacentTerritories(Array[westernEU, iceland, scandinavia, northEU])

    scandinavia.setAdjacentTerritories(Array[britain, iceland, ukraine])

    westernEU.setAdjacentTerritories(Array[northEU, southEU, britain, north_africa])

    northEU.setAdjacentTerritories(Array[britain, westernEU, southEU, ukraine])

    ukraine.setAdjacentTerritories(Array[scandinavia, northEU, southEU, afghanistan, ural, middleEast])

    southEU.setAdjacentTerritories(Array[westernEU, northEU, ukraine, middleEast, egypt, north_africa])

    middleEast.setAdjacentTerritories(Array[egypt, southEU, ukraine, afghanistan, india, east_africa])

    afghanistan.setAdjacentTerritories(Array[ukraine, ural, china, india, middleEast])

    ural.setAdjacentTerritories(Array[siberia, ukraine, afghanistan, china])

    siberia.setAdjacentTerritories(Array[ural, china, yakursk, irkutsk, mongolia, china])

    yakursk.setAdjacentTerritories(Array[siberia, irkutsk, kamtchatka])

    irkutsk.setAdjacentTerritories(Array[siberia, yakursk, mongolia, kamtchatka])

    mongolia.setAdjacentTerritories(Array[siberia, irkutsk, china, kamtchatka, japan])

    kamtchatka.setAdjacentTerritories(Array[alaska, japan, mongolia, irkutsk, yakursk])

    japan.setAdjacentTerritories(Array[mongolia, kamtchatka])

    china.setAdjacentTerritories(Array[mongolia, siberia, ural, afghanistan, india, siam])

    india.setAdjacentTerritories(Array[middleEast, afghanistan, china, siam])

    siam.setAdjacentTerritories(Array[indonesia, india, china])

    indonesia.setAdjacentTerritories(Array[siam, newGuinea, westAustralia])

    newGuinea.setAdjacentTerritories(Array[eastAustralia, indonesia, westAustralia])

    westAustralia.setAdjacentTerritories(Array[eastAustralia, indonesia, newGuinea])

    eastAustralia.setAdjacentTerritories(Array[newGuinea, westAustralia])

    @territories.push(chile)
    @territories.push(venezuela)
    @territories.push(argentina)
    @territories.push(brazil)

    southAmerica = Continent.new(self, "South America", Array[chile, venezuela, argentina, brazil], 2)
    @continents.push(southAmerica)

    @territories.push(mexico) 
    @territories.push(easternUS)
    @territories.push(westernUS)
    @territories.push(quebec)   
    @territories.push(ontario)  
    @territories.push(alberta)  
    @territories.push(alaska)
    @territories.push(northwest)
    @territories.push(greenland)

    northAmerica = Continent.new(self, "North America", Array[mexico, easternUS, westernUS, quebec, ontario, alberta, alaska, northwest, greenland], 5)
    @continents.push(northAmerica)

    @territories.push(iceland)
    @territories.push(britain)
    @territories.push(westernEU)
    @territories.push(northEU)
    @territories.push(southEU)
    @territories.push(scandinavia)
    @territories.push(ukraine)

    europe = Continent.new(self, "Europe", Array[iceland, britain, westernEU, northEU, southEU, scandinavia, ukraine], 5)
    @continents.push(europe)

    @territories.push(afghanistan)
    @territories.push(ural)
    @territories.push(siberia)
    @territories.push(yakursk)
    @territories.push(kamtchatka)
    @territories.push(irkutsk)
    @territories.push(mongolia)
    @territories.push(japan)
    @territories.push(china)
    @territories.push(middleEast)
    @territories.push(india)
    @territories.push(siam)

    asia = Continent.new(self, "Asia", Array[afghanistan, ural, siberia, yakursk, kamtchatka, irkutsk, mongolia, japan, china, middleEast, india, siam], 7)
    @continents.push(asia)

    @territories.push(indonesia)
    @territories.push(newGuinea)
    @territories.push(eastAustralia)
    @territories.push(westAustralia)

    oceania = Continent.new(self, "Oceania", Array[indonesia, newGuinea, eastAustralia, westAustralia], 2)
    @continents.push(oceania)

    @territories.push(north_africa)
    @territories.push(south_africa)
    @territories.push(central_africa)
    @territories.push(egypt)
    @territories.push(east_africa)
    @territories.push(madagascar)

    africa = Continent.new(self, "Africa", Array[north_africa, south_africa, central_africa, egypt, east_africa, madagascar], 3)
    @continents.push(africa)    
  end

  def initObjectives()
    cSAandAS = ConquerObjective.new(self, [@continents[0], @continents[3]], "South America and Asia")
    cSAandNAandOC = ConquerObjective.new(self, [@continents[0], @continents[1], @continents[4]], "South America, North America and Oceania")
    cEUandAFandOC = ConquerObjective.new(self, [@continents[2], @continents[4], @continents[5]], "Europe, Oceania and Africa")
    cNAandAf = ConquerObjective.new(self, [@continents[1], @continents[5]], "North America and Africa")
    cAFandAS = ConquerObjective.new(self, [@continents[5], @continents[3]], "Africa and Asia")
    cEUandAS = ConquerObjective.new(self, [@continents[2], @continents[3]], "Europe and Asia")

    territories = TerritoryObjective.new(self, @territories, 35, "35 Territories")

    @objectives = [cSAandAS, cSAandNAandOC, cEUandAFandOC, cNAandAf, cAFandAS, cEUandAS, territories]
  end

  def randTerritories()
    @territories.each_with_index do |territory, index|
      if index % 2 == 0
        territory.setPlayer(@player1.getId())
        territory.setActiveImage(Constants::PLAYER1_IMAGE)
      else
        territory.setPlayer(@player2.getId())
        territory.setActiveImage(Constants::PLAYER2_IMAGE)
        territory.setMainImage(Constants::PLAYER2_IMAGE)
      end
    end
  end

  def getMain()
    return @main
  end

  def getState()
    return @state
  end

  def setState(newState)
    @state = newState
  end

  def playerTurn()
    @playerTurn
  end

  def add_button (button)
    @buttons.push(button)
    @main
  end

  def getPreSelectedTerritory()
    @preSelectedTerritory
  end

  def setPreSelectedTerritory(preSelectedTerritory)
    if preSelectedTerritory == nil
      @territories.each do |territory|
        territory.returnToNormalState()
      end
      if @conquest != nil
        @conquest.getDefense().setAsMovable()
      end
      @preSelectedTerritory = nil
      return
    end
    if preSelectedTerritory.getPlayerId() == @playerTurn.getId()
      @preSelectedTerritory = preSelectedTerritory
      if @state == Constants::ATTACK
        self.paintAttackables()
      elsif @state == Constants::MANAGEMENT
        self.paintMovables()
      end
    end
  end

  def getConquest()
    @conquest
  end

  def setConquest(conquest)
    @ui.update()
    @conquest = conquest
  end

  def paintAttackables()
    @preSelectedTerritory.getAdjacentTerritories().each do |territory|
      if territory.getPlayerId() != @playerTurn.getId()
        territory.setAsAttackable()
      end
    end
  end 

  def paintMovables()
    @preSelectedTerritory.getAdjacentTerritories().each do |territory|
      if territory.getPlayerId() == @playerTurn.getId()
        territory.setAsMovable()
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

  def handleshowObjectives()
    if !@hasSeenObj1
      @ui.update(@player1.getObjective().getName())
      @hasSeenObj1 = true
    elsif !@hasSeenWarning2
      @ui.update("Player 1 close your eyes!")
      @hasSeenWarning2 = true
    elsif !@hasSeenObj2
      @ui.update(@player2.getObjective().getName())
      @hasSeenObj2 = true
    else
      self.setState(Constants::ORGANIZE_PHASE)
      @ui.update()
    end
  end

  def handleOrganizePhase()
    if @playerTurn.getTroopsAvailable() != 0
      @ui.update("MUST EMPTY TROOPS!")
    elsif organizePhaseEnded()
      self.changeTurn()
      @state = Constants::TROOP_PLACEMENT
      self.initTroopPlacement
      @ui.update()
      @territories.each do |territory|
        territory.updateRoundTroops()
      end
    else
      @ui.update()
      self.changeTurn()
    end
  end

  def initTroopPlacement()
    player = playerTurn
    numOfTerritories = 0
    @territories.each do |territory|
      if territory.getPlayerId() == player.getId()
        numOfTerritories += 1
      end
    end
    numOfPlaceableTroops = (numOfTerritories/2).floor
    player.increaseTroops(numOfPlaceableTroops)
  end

  def handleTroopPlacement()
    if @playerTurn.getTroopsAvailable() != 0
      @ui.update("MUST EMPTY TROOPS!")
    else
      self.setState(Constants::ATTACK)
      @ui.update()
    end
  end

  def handleAttack()
    @territories.each do |territory|
      territory.updateRoundTroops()
      territory.returnToNormalState()
      @conquest = nil
      @preSelectedTerritory = nil
    end
    self.setState(Constants::MANAGEMENT)
    @ui.update()
  end
  
  def handleVictoryManagement()
    if @conquest.getDefense().getNumOfTroops() == 0
      @ui.update("MUST FILL TERRITORY!")
    else
      self.setState(Constants::ATTACK)
      @conquest.getDefense().returnToNormalState()
      self.setConquest(nil)
    end
  end

  def handleManagement()
    @territories.each do |territory|
      territory.updateRoundTroops()
      territory.returnToNormalState()
      territory.resetRemanagedTroops()
      @preSelectedTerritory = nil
    end
    self.setState(Constants::TROOP_PLACEMENT)
    if @playerTurn.isWinner()
      self.setState(Constants::GAME_FINISHED)
      if @playerTurn.getId() == 0
        @ui.update("PLAYER 1 WON!")
      else
        @ui.update("PLAYER 2 WON!")
      end
    else
      self.changeTurn()
      self.initTroopPlacement()  
    end
  end

  def pressedKey(id)
    if id == Gosu::KB_RETURN && @state == Constants::SHOWING_OBJECTIVES
      self.handleshowObjectives()
    elsif id == Gosu::KB_RETURN && @state == Constants::ORGANIZE_PHASE
      self.handleOrganizePhase()
    elsif id == Gosu::KB_RETURN && @state == Constants::TROOP_PLACEMENT
      self.handleTroopPlacement()
    elsif id == Gosu::KB_RETURN && @state == Constants::ATTACK
      self.handleAttack()
    elsif id == Gosu::KB_RETURN && @state == Constants::VICTORY_MANAGEMENT
      self.handleVictoryManagement()
    elsif id == Gosu::KB_RETURN && @state == Constants::MANAGEMENT
      self.handleManagement()
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