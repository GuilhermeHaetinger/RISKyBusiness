$LOAD_PATH << '.'

require 'gosu'
require 'Menu'
require 'Cursor'
require 'Game'
require 'modules/constants'
require 'modules/zorder'


class Main < Gosu::Window
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
		if id == Gosu::MsLeft && @onMenu
			@menu.clicked()
    elsif id == Gosu::MsLeft && @onGame
      @game.clicked()
    elsif id == Gosu::KB_RETURN && @onGame
      @game.changeTurn()
    elsif id == Gosu::KB_ESCAPE && @onGame
      @onGame = false
      @onMenu = true
    end
	end
end

main = Main.new.show