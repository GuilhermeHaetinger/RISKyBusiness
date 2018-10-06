$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'

class PlayButton < Button
  def initialize(window, x, y)
    super(window, Gosu::Image.new('../assets/img/item.png', false), x, y, ZOrder::UI, 
      lambda{ self.callback }, Gosu::Image.new('../assets/img/item_hover.png', false))
  end

  def callback ()
    @window.playGame()
  end
end