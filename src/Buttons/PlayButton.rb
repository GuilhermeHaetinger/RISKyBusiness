$LOAD_PATH << 'Buttons'
require 'ruby2d'
require 'Button'
require 'Game'

class PlayButton < Button
  def initialize(x,y)
    super(x, y, 'green', 'white')
    @title = Text.new(
      x: x+25, 
      y: y+10, 
      z: 2,
      text: 'Play', 
      size: 20,
      font: "../assets/fonts/Merienda-Regular.ttf",
      color: 'black'
    )
  end

  def do()
    puts 'Starting Game'
  end
end

