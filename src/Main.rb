$LOAD_PATH << '.'

require 'gosu'
require 'Menu'
require 'Cursor'
require 'Game'
require 'modules/constants'
require 'modules/zorder'
require 'modules/auxiliar'


class Main < Gosu::Window
  include Auxiliar

  def initialize()
    super(Constants::WINDOW_WIDTH, Constants::WINDOW_HEIGHT)
    self.caption = 'RISKyBusiness'
    @onMenu = true
    @onGame = false
    @menu = Menu.new(self)
    @game = nil
    @cursor = Cursor.new(self)

  end

  def playGame()
    @onMenu = false
    @onGame = true
    @game = Game.new(self)
  end

  def draw ()
    @cursor.draw()
    if @onMenu 
      @menu.draw()
    else @onGame
      @game.draw()
    end
  end

  def update ()
    @menu.update()
  end

  def button_down (id)
		if isMouseClick(id) && @onMenu
			@menu.clicked(id)
    elsif isMouseClick(id) && @onGame
      @game.clicked(id)
    elsif id == Gosu::KB_RETURN && @onGame
      @game.pressedKey(id)
    elsif id == Gosu::KB_ESCAPE && @onGame
      @onGame = false
      @game = nil
      @onMenu = true
    end
  end
  
  def setOnGame(opt)
    @onGame = false
    @game = nil
  end

  def setOnMenu(opt)
    @onMenu = true
  end
end

main = Main.new.show