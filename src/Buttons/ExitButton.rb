$LOAD_PATH << 'Buttons'
require 'ruby2d'
require 'Button'

class ExitButton < Button
  def initialize(x,y)
    super(x, y, 'red', 'white')
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

  def do()
    puts 'Game Ended'
    exit
  end
end

