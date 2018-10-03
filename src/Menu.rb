$LOAD_PATH << '.'
require 'ruby2d'
require 'observer'

require 'Game'
require 'Buttons/ExitButton'
require 'Buttons/PlayButton'
require 'Buttons/OptionsButton'

class Menu
  include Observable

  def initialize(main)
    self.add_observer(main)

    @background = Image.new(
      path: "../assets/img/main_bg.jpg",
      x: 0,
      y: 0,
      width: 600,
      height: 450
    )
    @title = Text.new(
      x: 150, 
      y: 100, 
      text:"RISKy Business", 
      size: 40,
      font: "../assets/fonts/Merienda-Regular.ttf"
    )

    @onMenu = true
    @buttons = Array.new
    @buttons.push(PlayButton.new(250, 190, self))
    @buttons.push(OptionsButton.new(250, 250, self))
    @buttons.push(ExitButton.new(250, 310, self))
  end

  def onMenu=(value)
    @onMenu = value
  end

  def updateButtons()
    Window.on :mouse_move do |e|
      if @onMenu
        updateButtonsHovers(e)
      end
    end

    Window.on :mouse_down do |e|
      if @onMenu
        verifyButtonsFunctions(e)
      end
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

  def playButtonFunction()
    puts 'Triggered PlayButton'
    @buttons.each { |button| button.release()}
    @onMenu = false
    changed
    notify_observers('startGame')
  end

  def optionsButtonFunction()
    puts 'Triggered OptionsButton'
  end

  def exitButtonFunction()
    puts 'Triggered ExitButton'
    changed
    notify_observers('exitGame')
  end

  def update(event)
    case event
    when 'PlayButton'
      playButtonFunction()
    when 'OptionsButton'
      optionsButtonFunction()
    when 'ExitButton'
      exitButtonFunction()
    end
  end
  
  def loop()
    tick = 0
    if tick % 60 == 0
      updateButtons()
    end
    if !@onMenu
      return
    end
    tick += 1
  end
end