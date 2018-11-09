$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'

class ExitButton < Button
  def initialize(window, x, y)
    super(window, Gosu::Image.new('../assets/img/EXIT.png', false), x, y, ZOrder::UI, 
      method(:callback), Gosu::Image.new('../assets/img/EXITHOVER.png', false))
  end

  def callback ()
    exit()
  end
end