$LOAD_PATH << '.'

require 'gosu'
require './Modules/constants.rb'
require './Modules/zorder.rb'

Player = Struct.new(:id, :objective)
Territory = Struct.new(:name, :playerId, :troops, :x, :y)
Button = Struct.new(:name, :image, :x, :y)

turnPlayer = nil
$listOfPlayers = Array.new
$listOfTerritories = Array.new
$mapOfAdjacence = Hash.new
$coninents = Hash.new
$objectives = Array.new

$listOfTerritories.push(Territory.new("Chile", nil, 1, 211, 478)) # Chile
$listOfTerritories.push(Territory.new("Venezuela", nil, 1, 254, 393)) # Venezuela
$listOfTerritories.push(Territory.new("Argentina", nil, 1, 286, 592)) # Argentina
$listOfTerritories.push(Territory.new("Brazil", nil, 1, 399, 481)) # Brazil
$listOfTerritories.push(Territory.new("Mexico", nil, 1, 200, 320)) # Mexico
$listOfTerritories.push(Territory.new("Eastern US", nil, 1, 270, 250)) # Eastern US
$listOfTerritories.push(Territory.new("Western US", nil, 1, 170, 235)) # Western US
$listOfTerritories.push(Territory.new("Quebec", nil, 1, 350, 180)) # Quebec
$listOfTerritories.push(Territory.new("Ontario", nil, 1, 275, 170)) # Ontario
$listOfTerritories.push(Territory.new("Alberta", nil, 1, 180, 160)) # Alberta
$listOfTerritories.push(Territory.new("Alaska", nil, 1, 50, 100)) # Alaska
$listOfTerritories.push(Territory.new("Northwest Territory", nil, 1, 170, 90)) # Northwest Territory
$listOfTerritories.push(Territory.new("Greenland", nil, 1, 470, 55)) # Greenland
$listOfTerritories.push(Territory.new("Iceland", nil, 1, 500, 120)) # Iceland
$listOfTerritories.push(Territory.new("Britain", nil, 1, 485, 200)) # Britain
$listOfTerritories.push(Territory.new("Western EU", nil, 1, 475, 270)) # Western EU
$listOfTerritories.push(Territory.new("North EU", nil, 1, 570, 210)) # North EU
$listOfTerritories.push(Territory.new("South EU", nil, 1, 590, 280)) # South EU
$listOfTerritories.push(Territory.new("Scandinavia", nil, 1, 600, 100)) # Scandinavia
$listOfTerritories.push(Territory.new("Ukraine", nil, 1, 690, 150)) # Ukraine
$listOfTerritories.push(Territory.new("Afghanistan", nil, 1, 795, 235)) # Afghanistan
$listOfTerritories.push(Territory.new("Ural", nil, 1, 810, 130)) # Ural
$listOfTerritories.push(Territory.new("Siberia", nil, 1, 900, 110)) # Siberia
$listOfTerritories.push(Territory.new("Yakursk", nil, 1, 1025, 100)) # Yakursk
$listOfTerritories.push(Territory.new("Kamtchatka", nil, 1, 1150, 110)) # Kamtchatka
$listOfTerritories.push(Territory.new("Irkutsk", nil, 1, 990, 170)) # Irkutsk
$listOfTerritories.push(Territory.new("Mongolia", nil, 1, 1020, 230)) # Mongolia
$listOfTerritories.push(Territory.new("Japan", nil, 1, 1100, 250)) # Japan
$listOfTerritories.push(Territory.new("China", nil, 1, 920, 280)) # China
$listOfTerritories.push(Territory.new("Middle", nil, 1, 725, 350)) # Middle East
$listOfTerritories.push(Territory.new("India", nil, 1, 850, 390)) # India
$listOfTerritories.push(Territory.new("Siam", nil, 1, 950, 370)) # Siam
$listOfTerritories.push(Territory.new("Indonesia", nil, 1, 920, 460)) # Indonesia
$listOfTerritories.push(Territory.new("New Guinea", nil, 1, 1150, 480)) # New Guinea
$listOfTerritories.push(Territory.new("Eastern Australia", nil, 1, 1100, 550)) # Eastern Australia
$listOfTerritories.push(Territory.new("Western Australia", nil, 1, 970, 580)) # Western Australia
$listOfTerritories.push(Territory.new("North Africa", nil, 1, 502, 390)) # North Africa
$listOfTerritories.push(Territory.new("South Africa", nil, 1, 588, 617)) # South Africa
$listOfTerritories.push(Territory.new("Central Africa", nil, 1, 606, 495)) # Central Africa
$listOfTerritories.push(Territory.new("Egypt", nil, 1, 633, 362)) # Egypt
$listOfTerritories.push(Territory.new("East Africa", nil, 1, 702, 463)) # East Africa
$listOfTerritories.push(Territory.new("Madagascar", nil, 1, 712, 580)) # Madagascar

$mapOfAdjacence["Chile"]               = Array["Venezuela", "Argentina", "Brazil"]
$mapOfAdjacence["Venezuela"]           = Array["Chile", "Brazil", "Mexico"]
$mapOfAdjacence["Argentina"]           = Array["Chile", "Brazil"]
$mapOfAdjacence["Brazil"]              = Array["Chile", "Venezuela", "Argentina"]
$mapOfAdjacence["Mexico"]              = Array["Venezuela", "Western US", "Eastern US"]
$mapOfAdjacence["Eastern US"]          = Array["Western US", "Mexico", "Ontario", "Quebec"]
$mapOfAdjacence["Western US"]          = Array["Eastern US", "Mexico", "Alberta", "Ontario"]
$mapOfAdjacence["Quebec"]              = Array["Eastern US", "Ontario", "Greenland"]
$mapOfAdjacence["Ontario"]             = Array["Western US", "Eastern US", "Alberta", "Northwest Territory", "Quebec", "Greenland"]
$mapOfAdjacence["Alberta"]             = Array["Western US", "Ontario", "Northwest Territory", "Alaska"]
$mapOfAdjacence["Alaska"]              = Array["Northwest Territory", "Alberta", "Kamtchatka"]
$mapOfAdjacence["Northwest Territory"] = Array["Alaska", "Alberta", "Ontario", "Greenland"]
$mapOfAdjacence["Greenland"]           = Array["Northwest Territory", "Quebec", "Iceland"]
$mapOfAdjacence["Iceland"]             = Array["Greenland", "Britain", "Scandinavia"]
$mapOfAdjacence["Britain"]             = Array["Western EU", "Iceland", "Scandinavia", "North EU"]
$mapOfAdjacence["Western EU"]          = Array["North EU", "South EU", "Britain", "North Africa"]
$mapOfAdjacence["North EU"]            = Array["Britain", "Western EU", "South EU", "Ukraine"]
$mapOfAdjacence["South EU"]            = Array["Western EU", "North EU", "Ukraine", "Middle", "Egypt", "North Africa"]
$mapOfAdjacence["Scandinavia"]         = Array["Britain", "Iceland", "Ukraine"]
$mapOfAdjacence["Ukraine"]             = Array["Scandinavia", "North EU", "South EU", "Afghanistan", "Ural", "Middle"]
$mapOfAdjacence["Afghanistan"]         = Array["Ukraine", "Ural", "China", "India", "Middle"]
$mapOfAdjacence["Ural"]                = Array["Siberia", "Ukraine", "Afghanistan", "China"]
$mapOfAdjacence["Siberia"]             = Array["Ural", "China", "Yakursk", "Irkutsk", "Mongolia", "China"]
$mapOfAdjacence["Yakursk"]             = Array["Siberia", "Irkutsk", "Kamtchatka"]
$mapOfAdjacence["Kamtchatka"]          = Array["Alaska", "Japan", "Mongolia", "Irkutsk", "Yakursk"]
$mapOfAdjacence["Irkutsk"]             = Array["Siberia", "Yakursk", "Mongolia", "Kamtchatka"]
$mapOfAdjacence["Mongolia"]            = Array["Siberia", "Irkutsk", "China", "Kamtchatka", "Japan"]
$mapOfAdjacence["Japan"]               = Array["Mongolia", "Kamtchatka"]
$mapOfAdjacence["China"]               = Array["Mongolia", "Siberia", "Ural", "Afghanistan", "India", "Siam"]
$mapOfAdjacence["Middle"]              = Array["Egypt", "South EU", "Ukraine", "Afghanistan", "India", "East Africa"]
$mapOfAdjacence["India"]               = Array["Middle", "Afghanistan", "China", "Siam"]
$mapOfAdjacence["Siam"]                = Array["Indonesia", "India", "China"]
$mapOfAdjacence["Indonesia"]           = Array["Siam", "New Guinea", "Western Australia"]
$mapOfAdjacence["New Guinea"]          = Array["Eastern Australia", "Indonesia", "Western Australia"]
$mapOfAdjacence["Eastern Australia"]   = Array["Eastern Australia", "Indonesia", "Western Australia"]
$mapOfAdjacence["Western Australia"]   = Array["Eastern Australia", "Indonesia", "New Guinea"]
$mapOfAdjacence["North Africa"]        = Array["Central Africa", "Egypt", "East Africa", "Western EU", "South EU"]
$mapOfAdjacence["South Africa"]        = Array["Madagascar", "Central Africa", "East Africa"]
$mapOfAdjacence["Central Africa"]      = Array["North Africa", "East Africa", "South Africa"]
$mapOfAdjacence["Egypt"]               = Array["East Africa", "North Africa", "South EU", "Middle"]
$mapOfAdjacence["East Africa"]         = Array["Central Africa", "North Africa", "Egypt", "South Africa"]
$mapOfAdjacence["Madagascar"]          = Array["South Africa"]

$coninents["South America"] = Array["Chile", "Venezuela", "Argentina", "Brazil"]
$coninents["North America"] = Array["Mexico", "Eastern US", "Western US", "Quebec", "Ontario", "Alberta", "Alaska", "Northwest Territory", "Greenland"]
$coninents["Europe"]        = Array["Iceland", "Britain", "Western EU", "North EU", "South EU", "Scandinavia", "Ukraine"]
$coninents["Asia"]          = Array["Afghanistan", "Ural", "Siberia", "Yakursk", "Kamtchatka", "Irkutsk", "Mongolia", "Japan", "China", "Middle", "India", "Siam"]
$coninents["Oceania"]       = Array["Indonesia", "New Guinea", "Eastern Australia", "Western Australia"]
$coninents["Africa"]        = Array["North Africa", "South Africa", "Central Africa", "Egypt", "East Africa", "Madagascar"]



def startGame
    $listOfTerritories = splitTerritories($listOfTerritories)
    # MENU
    # TODO UI
    # START
    
    #OBJECTIVE SELECTION

end

def splitTerritories(list)
    territoriesDistribution = (0..(list.length - 1)).to_a.shuffle
    player1, player2 = territoriesDistribution.each_slice(territoriesDistribution.size/2).to_a
    newList = Array[]
    player1.map{|x| terr = list[x];newList.push(Territory.new(terr[:name], 1, terr[:troops], terr[:x], terr[:y]))}
    player2.map{|x| terr = list[x];newList.push(Territory.new(terr[:name], 2, terr[:troops], terr[:x], terr[:y]))}

    newList
end

def selectObjectives
    obj1 = $objectives[rand($objectives.length - 1)]
end
# # listOfTerritories.map{|x| puts x[:name]}

# startGame
# $listOfTerritories.sort_by{|x| x[:playerId]}
# $listOfTerritories.map{|x| puts x[:playerId]}
puts rand(2)


