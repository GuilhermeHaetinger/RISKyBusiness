$LOAD_PATH << '.'
require 'ruby2d'
require 'Button'

class PlayButton < Button
  def initialize(x,y, menu)
    super(x, y, 'green', 'white', menu)
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
  
  def release()
    @title.remove
    self._release()
  end
end

