$LOAD_PATH << '.'

require 'MenuItem'
require './buttons/ExitButton'
require './buttons/PlayButton'

class Menu
  def initialize (window)
    @window = window
    @buttons = Array.new
    @background_image = Gosu::Image.new(
      "../assets/img/main_bg.jpg", 
      tileable: true
    )
    add_button (ExitButton.new(window, 590,500))
    add_button (PlayButton.new(window, 530,440))
  end

  def add_button (button)
    @buttons.push(button)
    @window
  end

  def draw ()
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @buttons.each do |i|
      i.draw()
    end
  end

  def update ()
    @buttons.each do |i|
      i.update()
    end
  end

  def clicked ()
    @buttons.each do |i|
        i.clicked()
    end
  end
end