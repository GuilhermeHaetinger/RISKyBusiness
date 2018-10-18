$LOAD_PATH << '.'
require './modules/constants'
require 'Territory'
# require 'Player'

class Continent
	def initialize(game, c_name, territories, extraArmies)
		@territories = territories
		@name = c_name
		@game = game
		@extraArmies = extraArmies
	end

	def getName()
		return @name
	end

	def getTerritories()
		return @territories
	end

	def getExtraArmies()
		return @extraArmies
	end

	def conqueredByPlayer(playerId)
		for territory in @territories
			if territory.getPlayerId != playerId
				return false
			end
		end
		return true
	end	
end