$LOAD_PATH << '.'
require './modules/constants'
require 'Territory'
require 'Player'

class Dice

	def initialize(game)
		@game = game
		@numOfRolls = 0
	end

	def getNumOfRolls()
		return @numOfRolls
	end

	def setNumOfRolls(numOfRolls)
		@numOfRolls = numOfRolls
	end

	def roll()
		i = 0
		rollResults - Array.new(@numOfRolls)

		while i < numOfRolls
			rollResults.push((1 + rand(6)))
			i += 1
		end
		rollResults.sort!{|x, y| y <=> x}
		return rollResults
	end

end