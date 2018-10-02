$LOAD_PATH << '.'
require 'Game'
require 'ruby2d'
require 'Buttons/ExitButton'
require 'Buttons/PlayButton'
require 'Buttons/OptionsButton'

class Menu
  def initialize()
    @onMenu = true
    @onGame = false

    Window.set({ 
      title: "RISKy Business",
      background: "black",
      width: 600,
      height: 450,
      z: 0
    })
    @title = Text.new(
      x: 150, 
      y: 100, 
      text:"RISKy Business", 
      size: 40,
      font: "../assets/fonts/Merienda-Regular.ttf"
    )
    @buttons = Array.new
    @buttons.push(PlayButton.new(250, 190, self))
    @buttons.push(OptionsButton.new(250, 250, self))
    @buttons.push(ExitButton.new(250, 310, self))
  end

  def updateButtons()
    Window.on :mouse_move do |e|
      updateButtonsHovers(e)
    end

    Window.on :mouse_down do |e|
      verifyButtonsFunctions(e)
    end
  end

  def updateButtonsHovers(e)
    @buttons.each{ |button| 
      button.verifyHover(e.x, e.y)
    }
  end

  def verifyButtonsFunctions(e)
    @buttons.each{ |button| 
      if button.hovered
        button.do()
        if button.class == PlayButton
          @onMenu = false
          @onGame = true
        end
      end
    }
  end

  def updateGame()
    puts "Atualizando o Game"
  end

  def update(event)
    case event
    when 'PlayButton'
      puts 'Triggered PlayButton'
    when 'OptionsButton'
      puts 'Triggered OptionsButton'
    when 'ExitButton'
      puts 'Triggered ExitButton'
      exit
    end
  end
  
  def updateLoop()
    if @onMenu
      updateButtons()
    else @onGame
      updateGame()
    end
  end
  
  def loop()
    tick = 0
    Window.update do
      if tick % 60 == 0
        updateLoop()
      end
      tick += 1
    end
    Window.show
  end
end

menu = Menu.new
menu.loop

