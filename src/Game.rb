$LOAD_PATH << '.'
require './modules/constants'
require 'Territory'
require './ui/Ui'
require 'Player'
require 'Continent'
require 'Dice'
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
    @continents = Array.new
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

    britain.setAdjacentTerritories(Array[westernEU, scandinavia, northEU])

    scandinavia.setAdjacentTerritories(Array[britain, ukraine])

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

    africa  =Continent.new(self, "Africa", Array[north_africa, south_africa, central_africa, egypt, east_africa, madagascar], 3)
    @continents.push(africa)    
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