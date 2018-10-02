$LOAD_PATH << 'Buttons'
require 'ruby2d'
require 'Button'

class ExitButton < Button
  def initialize(x,y, menu)
    super(x, y, 'red', 'white', menu)
    @title = Text.new(
      x: x+27, 
      y: y+9, 
      z: 2,
      text: 'Exit', 
      size: 20,
      font: "../assets/fonts/Merienda-Regular.ttf",
      color: 'black'
    )
  end
end

