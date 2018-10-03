$LOAD_PATH << '.'
require 'Game'
require 'ruby2d'
require 'Menu'

class Main
  def initialize()
    Window.set({ 
      title: "RISKy Business",
      background: "black",
      width: 600,
      height: 450,
      z: 0
    })

    @onMenu = true
    @onGame = false
    @menu = Menu.new(self)
    @game = Game.new(self)
  end

  def mainLoop()
    tick = 0
    Window.update do
      if tick % 5 == 0
        if @onMenu
          if @menu == nil
            @menu = Menu.new(self)
          end
          @menu.loop()
        else @onGame
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
