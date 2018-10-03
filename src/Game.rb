$LOAD_PATH << '.'
require 'observer'
require 'ruby2d'

require 'Player'
require 'EnumObjective'
require 'Territories'

class Game
  include EnumObjective
  include Observable

  def initialize(main)
    self.add_observer(main)
    @onGame = true
  end

  def initializeTerritories; Territories.new end

  def releaseGame()
    @onGame = false
    Window.remove(@map)
    changed
    notify_observers('startMenu')
  end

  def updateGame()
    Window.on :key_down do |e|
      if @onGame
        if e.key == 'escape'
         releaseGame()
        end
      end
    end
  end

  def onGame=(value)
    @onGame = value
  end

  def play()
    tick = 0
    @map = Image.new(path: "../assets/img/MAP.jpg")
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
