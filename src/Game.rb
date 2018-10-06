$LOAD_PATH << '.'
require 'observer'
require 'ruby2d'

require 'Player'
require 'EnumObjective'
require 'Territory'
require 'modules/Constants'
include Constants

class Game
  include EnumObjective
  include Observable

  def initialize(main)
    self.add_observer(main)
    @onGame = true
    @territories = []
    @quitText = Text.new(
      x: 0, 
      y: 0,
      z: 1,
      color: 'black', 
      text:"Press ESC to quit", 
      size: 30,
      font: "../assets/fonts/Merienda-Regular.ttf"
    )
  end

  def initializeTerritories()
    @territories.push(Territory.new('Brazil' , [], [399,493]))
    @territories.push(Territory.new('Brazil' , [], [283,438]))
    @territories.push(Territory.new('Brazil' , [], [292,512]))
    @territories.push(Territory.new('Brazil' , [], [309,633]))

  end

  def releaseGame()
    @onGame = false
    Window.remove(@map)
    changed
    notify_observers('startMenu')
  end

  def showTerritories()
    @territories.each{ |territory| 
      territory.show()
    }
  end

  def updateGame()
    self.showTerritories()
    Window.on :key_down do |e|
      if @onGame
        if e.key == 'escape'
         exit
        end
      end
    end
  end

  def onGame=(value)
    @onGame = value
  end

  def play()
    tick = 0
    @map = Image.new(
      path: "../assets/img/MAP.jpg",
      x: 0,
      y: 0,
      width: WINDOW_WIDTH,
      height: WINDOW_HEIGHT
    )
    if tick % 60 == 0
      updateGame()
    end
    if !@onGame
      Window.close
      return
    end
    tick += 1
  end 
end
