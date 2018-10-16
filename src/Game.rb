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
    @territories.push(Territory.new(self,399,481))
    @territories.push(Territory.new(self,286,592))
    @territories.push(Territory.new(self,211,478))
    @territories.push(Territory.new(self,254,393))
    @territories.push(Territory.new(self,502,390))
    @territories.push(Territory.new(self,633,362))
    @territories.push(Territory.new(self,702,463))
    @territories.push(Territory.new(self,606,495))
    @territories.push(Territory.new(self,588,617))
    @territories.push(Territory.new(self,712,580))
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