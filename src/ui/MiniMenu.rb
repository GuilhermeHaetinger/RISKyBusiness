$LOAD_PATH << '.'

require './modules/zorder'
require './buttons/AttackButton'
require './buttons/MoveButton'

class MiniMenu
  def initialize(game, territory, x, y)
    @game = game
    @territory = territory
    @position = [x, y]
    @attackButton = AttackButton.new(game, x, y)
    @moveButton = MoveButton.new(game, x, y + 30)

  end

  def update()
  end

  def draw()
    @attackButton.draw()
    @moveButton.draw()
  end


end