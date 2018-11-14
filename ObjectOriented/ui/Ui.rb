$LOAD_PATH << '.'

require './ui/TroopsAvailable'
require './ui/GameState'

class Ui
  def initialize(game, main, player1, player2)
    @stateText = GameState.new(game)
    @game = game
    @player1TroopsAvailable = TroopsAvailable.new(player1, 10, 10)
    @player2TroopsAvailable = TroopsAvailable.new(player2, 950, 10)
  end

  def update(text="")
    @stateText.update(text)
    player1Turn = @game.playerTurn().getId() == 0
    @player1TroopsAvailable.update(player1Turn)
    @player2TroopsAvailable.update(!player1Turn)
  end

  def draw()
    @stateText.draw()
    @player1TroopsAvailable.draw()
    @player2TroopsAvailable.draw()
  end
end