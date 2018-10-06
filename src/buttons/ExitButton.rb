$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'

class ExitButton < Button
  def initialize(window, x, y)
    super(window, Gosu::Image.new('../assets/img/exit.png', false), x, y, ZOrder::UI, 
      lambda{ self.callback }, Gosu::Image.new('../assets/img/exit_hover.png', false))
  end

  def callback ()
    exit()
  end
end