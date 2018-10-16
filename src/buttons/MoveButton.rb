$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'

class MoveButton < Button
  def initialize(window, x, y)
    super(window, Gosu::Image.new('../assets/img/item.png', false), x, y, ZOrder::UI, 
      method(:callback), Gosu::Image.new('../assets/img/item_hover.png', false))
  end

  def callback (id)
    puts 'moving'
  end
end