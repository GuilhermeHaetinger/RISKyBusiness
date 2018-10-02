$LOAD_PATH << 'Buttons'
require 'ruby2d'
require 'Button'

class OptionsButton < Button
  def initialize(x,y, menu)
    super(x, y, 'orange', 'white', menu)
    @title = Text.new(
      x: x+10, 
      y: y+9, 
      z: 2,
      text: 'Options', 
      size: 20,
      font: "../assets/fonts/Merienda-Regular.ttf",
      color: 'black'
    )
  end
end

