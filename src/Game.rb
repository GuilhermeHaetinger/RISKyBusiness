$LOAD_PATH << '.'
require 'Player'
require 'EnumObjective'
require 'Territories'


class Game
    include EnumObjective
    def initializeTerritories; Territories.new end
    def play

    end 
end

game = Game.new

game.play
