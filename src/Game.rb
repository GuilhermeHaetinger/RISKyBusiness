$LOAD_PATH << '.'
require './modules/constants'
require './buttons/Territory'
require './ui/Ui'
require 'Player'
class Game
  def initialize (window)
    @window = window
    @buttons = Array.new
    @background_image = Gosu::Image.new(
      "../assets/img/MAP.jpg", 
      tileable: true
    )
    @player1 = Player.new('player1', 0)
    @player2 = Player.new('player2', 1)
    @ui = Ui.new(window, @player1, @player2)
    @positions = Array.new
    @playerTurn = @player1
    
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
    @positions.push(Territory.new(self,399,481))
    @positions.push(Territory.new(self,286,592))
    @positions.push(Territory.new(self,211,478))
    @positions.push(Territory.new(self,254,393))
    @positions.push(Territory.new(self,502,390))
    @positions.push(Territory.new(self,633,362))
    @positions.push(Territory.new(self,702,463))
    @positions.push(Territory.new(self,606,495))
    @positions.push(Territory.new(self,588,617))
    @positions.push(Territory.new(self,712,580))
  end

  def randTerritories()
    @positions.each_with_index do |position, index|
      if index % 2 == 0
        position.setPlayer(@player1.getId())
        position.setActiveImage(Gosu::Image.new('../assets/img/player2_troops.png', false))
      else
        position.setPlayer(@player2.getId())
        position.setActiveImage(Gosu::Image.new('../assets/img/player1_troops.png', false))
      end
    end
  end

  def getWindow()
    return @window
  end

  def playerTurn()
    @playerTurn
  end

  def add_button (button)
    @buttons.push(button)
    @window
  end

  def draw ()
    @ui.draw()
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @positions.each do |position| 
      position.draw()
    end
    @buttons.each do |i|
      i.draw()
    end
  end

  def update ()
    @ui.update()
    @positions.each do |position| 
      position.update()
    end
    @buttons.each do |i|
      i.update()
    end
  end

  def clicked ()
    @positions.each do |position| 
      position.clicked()
    end
    @buttons.each do |i|
        i.clicked()
    end
  end
end