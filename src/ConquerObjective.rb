$LOAD_PATH << '.'

require 'Continent'
require 'Objective'
require './modules/Interface'

class ConquerObjective < Objective
  
    def initialize(game, continents, name)
        @game = game
        @continents = continents
        super(name)
    end

    def isObjectiveFulfilled(playerId)
        @continents.each do |continent|
            if !continent.conqueredByPlayer(playerId)
                return false
            end
        end
        true
    end

end