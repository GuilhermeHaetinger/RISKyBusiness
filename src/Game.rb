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
    adjacents1 = Array[venezuela, argentina, brazil]
    chile.setAdjacentTerritories(adjacents1)
    
    adjacents2 = Array[chile, brazil, mexico]
    venezuela.setAdjacentTerritories(adjacents2)

    adjacents3 = Array[chile, brazil]
    argentina.setAdjacentTerritories(adjacents3)

    adjacents4 = Array[chile, venezuela, argentina]
    brazil.setAdjacentTerritories(adjacents4)

    adjacents5 = Array[central_africa, egypt, east_africa, westernEU, southEU]
    north_africa.setAdjacentTerritories(adjacents5)

    adjacents6 = Array[madagascar, central_africa, east_africa]
    south_africa.setAdjacentTerritories(adjacents6)

    adjacents7 = Array[north_africa, east_africa, south_africa]
    central_africa.setAdjacentTerritories(adjacents7)

    adjacents8 = Array[east_africa, north_africa, southEU, middleEast]
    egypt.setAdjacentTerritories(adjacents8)

    adjacents9 = Array[central_africa, north_africa, egypt, south_africa]
    east_africa.setAdjacentTerritories(adjacents9)

    adjacents10 = Array[south_africa]
    madagascar.setAdjacentTerritories(adjacents10)

    adjacents11 = Array[venezuela, westernUS, easternUS]
    mexico.setAdjacentTerritories(adjacents11)

    adjacents12 = Array[easternUS, mexico, alberta, ontario]
    westernUS.setAdjacentTerritories(adjacents12)

    adjacents13 = Array[westernUS, mexico, ontario, quebec]
    easternUS.setAdjacentTerritories(adjacents13)

    adjacents14 = Array[westernUS, ontario, northwest, alaska]
    alberta.setAdjacentTerritories(adjacents14)

    adjacents15 = Array[westernUS, easternUS, alberta, northwest, quebec, greenland]
    ontario.setAdjacentTerritories(adjacents15)

    adjacents16 = Array[easternUS, ontario, greenland]
    quebec.setAdjacentTerritories(adjacents16)

    adjacents17 = Array[northwest, alberta, kamtchatka]
    alaska.setAdjacentTerritories(adjacents17)

    adjacents18 = Array[alaska, alberta, ontario, greenland]
    northwest.setAdjacentTerritories(adjacents18)

    adjacents19 = Array[northwest, quebec, iceland]
    greenland.setAdjacentTerritories(adjacents19)

    adjacents20 = Array[greenland, britain, scandinavia]
    iceland.setAdjacentTerritories(adjacents20)

    adjacents21 = Array[westernEU, scandinavia, northEU]
    britain.setAdjacentTerritories(adjacents21)

    adjacents22 = Array[britain, ukraine]
    scandinavia.setAdjacentTerritories(adjacents22)

    adjacents23 = Array[northEU, southEU, britain, north_africa]
    westernEU.setAdjacentTerritories(adjacents23)

    adjacents24 = Array[britain, westernEU, southEU, ukraine]
    northEU.setAdjacentTerritories(adjacents24)

    adjacents25 = Array[scandinavia, northEU, southEU, afghanistan, ural, middleEast]
    ukraine.setAdjacentTerritories(adjacents25)

    adjacents26 = Array[westernEU, northEU, ukraine, middleEast, egypt, north_africa]
    southEU.setAdjacentTerritories(adjacents26)

    adjacents27 = Array[egypt, southEU, ukraine, afghanistan, india, east_africa]
    middleEast.setAdjacentTerritories(adjacents27)

    adjacents28 = Array[ukraine, ural, china, india, middleEast]
    afghanistan.setAdjacentTerritories(adjacents28)

    adjacents29 = Array[siberia, ukraine, afghanistan, china]
    ural.setAdjacentTerritories(adjacents29)

    adjacents30 = Array[ural, china, yakursk, irkutsk, mongolia, china]
    siberia.setAdjacentTerritories(adjacents30)

    adjacents31 = Array[siberia, irkutsk, kamtchatka]
    yakursk.setAdjacentTerritories(adjacents31)

    adjacents32 = Array[siberia, yakursk, mongolia, kamtchatka]
    irkutsk.setAdjacentTerritories(adjacents32)

    adjacents33 = Array[siberia, irkutsk, china, kamtchatka, japan]
    mongolia.setAdjacentTerritories(adjacents33)

    adjacents34 = Array[alaska, japan, mongolia, irkutsk, yakursk]
    kamtchatka.setAdjacentTerritories(adjacents34)

    adjacents35 = Array[mongolia, kamtchatka]
    japan.setAdjacentTerritories(adjacents35)

    adjacents36 = Array[mongolia, siberia, ural, afghanistan, india, siam]
    china.setAdjacentTerritories(adjacents36)

    adjacents37 = Array[middleEast, afghanistan, china, siam]
    india.setAdjacentTerritories(adjacents37)

    adjacents38 = Array[indonesia, india, china]
    siam.setAdjacentTerritories(adjacents38)

    adjacents39 = Array[siam, newGuinea, westAustralia]
    indonesia.setAdjacentTerritories(adjacents39)

    adjacents40 = Array[eastAustralia, indonesia, westAustralia]
    newGuinea.setAdjacentTerritories(adjacents40)

    adjacents41 = Array[eastAustralia, indonesia, newGuinea]
    westAustralia.setAdjacentTerritories(adjacents41)

    adjacents42 = Array[newGuinea, westAustralia]
    eastAustralia.setAdjacentTerritories(adjacents42)

    @territories.push(chile) # Chile
    @territories.push(venezuela) # Venezuela
    @territories.push(argentina) # Argentina
    @territories.push(brazil) # Brazil

    @territories.push(mexico) # Mexico 
    @territories.push(easternUS)
    @territories.push(westernUS)
    @territories.push(quebec)   
    @territories.push(ontario)  
    @territories.push(alberta)  
    @territories.push(alaska)
    @territories.push(northwest)
    @territories.push(greenland)

    @territories.push(iceland)
    @territories.push(britain)
    @territories.push(westernEU)
    @territories.push(northEU)
    @territories.push(southEU)
    @territories.push(scandinavia)
    @territories.push(ukraine)

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

    @territories.push(indonesia)
    @territories.push(newGuinea)
    @territories.push(eastAustralia)
    @territories.push(westAustralia)

    @territories.push(north_africa) # North Africa
    @territories.push(south_africa) # South Africa
    @territories.push(central_africa) # Central Africa
    @territories.push(egypt) # Egypt
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