$LOAD_PATH << '.'

require './ui/Score'
require './ui/TroopsAvailable'

class Ui
  def initialize(game, player1, player2)
    @score = Score.new(player1, player2)
    @player1TroopsAvailable = TroopsAvailable.new(player1, 10, 10)
    @player2TroopsAvailable = TroopsAvailable.new(player2, 950, 10)
  end

  def update()
    @score.update()
    @player1TroopsAvailable.update()
    @player2TroopsAvailable.update()
  end

  def draw()
    @score.draw()
    @player1TroopsAvailable.draw()
    @player2TroopsAvailable.draw()
  end
end