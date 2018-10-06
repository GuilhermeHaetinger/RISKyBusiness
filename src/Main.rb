$LOAD_PATH << '.'
require 'Game'
require 'ruby2d'
require 'Menu'
require 'modules/Constants'
include Constants

class Main
  def initialize()
    Window.set({ 
      title: "RISKy Business",
      background: "black",
      width: WINDOW_WIDTH,
      height: WINDOW_HEIGHT,
      z: 0
    })

    @onMenu = true
    @onGame = false
    @menu = Menu.new(self)
    @game = nil
  end

  def mainLoop()
    tick = 0
    Window.update do
      if tick % 5 == 0
        if @onMenu
          @game = nil
          if @menu == nil
            @menu = Menu.new(self)
          end
          @menu.loop()
        else @onGame
          @menu = nil
          if @game == nil 
            @game = Game.new(self)
            @game.initializeTerritories()
          end
          @game.onGame = true
          @game.play()
        end
      end
      tick += 1
    end
    Window.show
  end

  def update(event)
    case event
    when 'startGame'
      @onGame = true
      @onMenu = false
      @menu = nil
    when 'startMenu'
      @onGame = false
      @onMenu = true
    when 'exitGame'
      exit
    end
  end
end

main = Main.new()
main.mainLoop()
