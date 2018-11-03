$LOAD_PATH << '.'

require 'Continent'
require 'Objective'
require './modules/Interface'
require './modules/functional'
class TerritoryObjective < Objective
  
    def initialize(game, territories, number, name)
        @game = game
        @territories = territories
        @number = number
        super(name)
    end

    # Objective 8
    def countObjectives(territories, playerId)
        if Functional::empty(territories)
            return 0
        elsif head(territories).getPlayerId() == playerId
            return 1 + countObjectives(tail(territories), playerId)
        else 
            return 0 + countObjectives(tail(territories), playerId)
        end
    end

    def isObjectiveFulfilled(playerId)
        countObjectives(@territories, playerId) >= @number
    end

end