$LOAD_PATH << 'Buttons'
require 'ruby2d'
require 'Button'

class OptionsButton < Button
  def initialize(x,y)
    super(x, y, 'orange', 'white')
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

  def do()
    puts 'Starting Options'
  end
end

