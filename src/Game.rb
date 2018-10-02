$LOAD_PATH << '.'
require 'Player'
require 'EnumObjective'
require 'Territories'
require 'ruby2d'

class Game
  include EnumObjective
  def initialize()
  end
  def initializeTerritories; Territories.new end
  def play
    @map = Image.new(path: "../images/MAP.jpg")
  end 
end
