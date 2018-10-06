$LOAD_PATH << '.'

require 'gosu'
require 'Menu'
require 'Cursor'
require 'modules/constants'
require 'modules/zorder'


class Main < Gosu::Window
  def initialize()
    super(Constants::WINDOW_WIDTH, Constants::WINDOW_HEIGHT)
    self.caption = 'RISKyBusiness'
    @onMenu = true
    @onGame = false
    @menu = Menu.new(self)
    @cursor = Cursor.new(self)

  end

  def draw ()
    @cursor.draw()
    if @onMenu 
      @menu.draw
    end
  end

  def update ()
    @menu.update()
  end

  def button_down (id)
		if id == Gosu::MsLeft && @onMenu then
			@menu.clicked()
    end
	end
end

main = Main.new.show