$LOAD_PATH << '.'

require 'Continent'
require 'Objective'
require './modules/Interface'

class TerritoryObjective < Objective
  
    def initialize(game, territories, number, name)
        @game = game
        @territories = territories
        @number = number
        super(name)
    end

    def isObjectiveFulfilled(playerId)
        num = 0
        @territories.each do |territory|
            if territory.getPlayerId() == playerId
                num += 1
            end
        end
        num >= @number
    end

end