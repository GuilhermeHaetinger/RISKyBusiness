$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'

class PlayButton < Button
  def initialize(window, x, y)
    super(window, Gosu::Image.new('../assets/img/PLAY.png', false), x, y, ZOrder::UI, 
      method(:callback), Gosu::Image.new('../assets/img/PLAYHOVER.png', false))
  end

  def callback (id)
    @window.playGame()
  end
end