$LOAD_PATH << '.'

require 'gosu'
require 'qo'
require './Modules/constants.rb'
require './Modules/zorder.rb'

Player = Struct.new(:id, :objective)
Territory = Struct.new(:name, :playerId, :troops, :x, :y)
Button = Struct.new(:type, :name, :image, :x, :y)
Objective = Struct.new(:description, :function)

turnPlayer = nil
$listOfPlayers = Array.new
$listOfTerritories = Array.new
$mapOfAdjacence = Hash.new
$continents = Hash.new
$objectives = Array.new
$territoryButtons = Array.new
$status = nil
$shownObj1 = false
$shownObj2 = false
$availableTroops = nil
$conqueredTerritory = nil

$attacker = ""
$attacked = ""
$selected = ""

$territoryMinTroops = Hash.new
$territoryMovedTroops = Hash.new

def head(list) list.to_a[0];end
def tail(list) list.to_a[1..-1];end

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

$listOfTerritories.map {|x| $territoryMinTroops[x[:name]] = 1}

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

$continents["South America"] = Array["Chile", "Venezuela", "Argentina", "Brazil"]
$continents["North America"] = Array["Mexico", "Eastern US", "Western US", "Quebec", "Ontario", "Alberta", "Alaska", "Northwest Territory", "Greenland"]
$continents["Europe"]        = Array["Iceland", "Britain", "Western EU", "North EU", "South EU", "Scandinavia", "Ukraine"]
$continents["Asia"]          = Array["Afghanistan", "Ural", "Siberia", "Yakursk", "Kamtchatka", "Irkutsk", "Mongolia", "Japan", "China", "Middle", "India", "Siam"]
$continents["Oceania"]       = Array["Indonesia", "New Guinea", "Eastern Australia", "Western Australia"]
$continents["Africa"]        = Array["North Africa", "South Africa", "Central Africa", "Egypt", "East Africa", "Madagascar"]

$objectives.push(Objective.new("32 Territories", lambda {|id| return ($listOfTerritories.select{|x| x[:playerId] == id}).length >= 32}))
$objectives.push(Objective.new("Asia and Africa", lambda {|id| return !($continents["Asia"].all?{|x| x[:playerId] != id}) && !($continents["Africa"].all?{|x| x[:playerId] != id})}))
$objectives.push(Objective.new("Oceania, Europe and Africa", lambda {|id| return !($continents["Oceania"].all?{|x| x[:playerId] != id}) && !($continents["Europe"].all?{|x| x[:playerId] != id}) && !($continents["Africa"].all?{|x| x[:playerId] != id})}))
$objectives.push(Objective.new("Asia and Europe", lambda {|id| return !($continents["Asia"].all?{|x| x[:playerId] != id}) && !($continents["Europe"].all?{|x| x[:playerId] != id})}))
$objectives.push(Objective.new("North America and Africa", lambda {|id| return !($continents["North America"].all?{|x| x[:playerId] != id}) && !($continents["Africa"].all?{|x| x[:playerId] != id})}))
$objectives.push(Objective.new("South America, North America and Oceania", lambda {|id| return !($continents["North America"].all?{|x| x[:playerId] != id}) && !($continents["South America"].all?{|x| x[:playerId] != id}) && !($continents["Oceania"].all?{|x| x[:playerId] != id})}))
$objectives.push(Objective.new("Asia and South America", lambda {|id| return !($continents["Asia"].all?{|x| x[:playerId] != id}) && !($continents["South America"].all?{|x| x[:playerId] != id})}))


def startGame
    $listOfTerritories = splitTerritories($listOfTerritories)
    $territoryButtons = $listOfTerritories.map{|x| image = x[:playerId] == 1 ? Constants::PLAYER1_IMAGE : Constants::PLAYER2_IMAGE;Button.new("TERRITORY", x[:name], image, x[:x], x[:y])}
    # MENU
    # TODO UI
    # START
    #OBJECTIVE SELECTION
    objective1, objective2 = get2RandomObjectives($objectives)
    player1 = Player.new(1, objective1)
    player2 = Player.new(2, objective2)
    $listOfPlayers = [player1, player2]
    $turnPlayer = 1
    $status = Constants::SHOWING_OBJECTIVES
    # SHOW OBJECTIVES
    #PLAYER 2 CLOSE YOUR EYES
    puts "player 2 close your eyes"
end

def changeTurn(id)
    id == 1 ? 2 : 1
end


def getSpecificAdjacentTerritories(boolOp, territory, mapOfAdjacence, territories)
    mapOfAdjacence[territory[:name]].select{|x| territory[:playerId].send(boolOp, getTerritory(x, territories)[:playerId])};
end

def changeTroops(op, n, territoryName, territories, min)
    territories.map {|x| (x[:name] == territoryName && x[:troops].send(op, n) >= min) ? (puts "#{x[:troops]} -> #{x[:troops].send(op, n)}";
                                                                                        $availableTroops = $availableTroops.send(op, -n);
                                                                                        Territory.new(x[:name], x[:playerId], x[:troops].send(op, n), x[:x], x[:y])) : x}
end

# CURRY
$getAdjacentAllies = method(:getSpecificAdjacentTerritories).to_proc.curry["=="]
$getAdjacentEnemies = method(:getSpecificAdjacentTerritories).to_proc.curry["!="]
$addTroop = method(:changeTroops).to_proc.curry["+"]
$decTroop = method(:changeTroops).to_proc.curry["-"]


def selectAsAttacker(territoryName, turnPlayer, territories, buttons)
    territory = getTerritory(territoryName, territories)
    territory[:playerId] == turnPlayer ? (paintTroops(Constants::ATTACK_IMAGE, ($getAdjacentEnemies[territory, $mapOfAdjacence, $listOfTerritories]), buttons);puts territoryName;territoryName) : ""
end

def selectAsAttacked(territoryName, turnPlayer, territories)
    territory = getTerritory(territoryName, territories)
    territory[:playerId] != turnPlayer ? (puts territoryName;territoryName) : ""
end

def updateTroops(territories)
    newMinTroops = Hash.new
    $listOfTerritories.map {|x| $territoryMinTroops[x[:name]] = x[:troops]}
end

def numOfTerritories(id, territories)
    territories.select{|x| x[:playerId] == id}.length
end

def getTroopsAvailable(id, territories)
    numOfTerritories(id, territories) / 2
end

def getTerritory(name, territories)
    if name == head(territories)[:name]
        head(territories)
    elsif territories.length == 1
        nil
    else
        getTerritory(name, tail(territories))
    end

end

def updateTerritories(territory, territories)
    territories.map{|x| x[:name] == territory[:name] ? territory : x}
end

def paintTroop(color, territory, buttons)
    buttons.map{|btn| (btn[:name] == territory) ? Button.new(btn[:type], btn[:name], color, btn[:x], btn[:y]) : btn}
end

def paintTroops(color, territories, buttons)
    paintTroop(color, head(territories), buttons)
    if territories.length != 1
        paintTroops(color, tail(territories), buttons)
    end
end

def get2RandomObjectives(list)
    objectiveDistribution = (0..(list.length - 1)).to_a.shuffle
    [list[objectiveDistribution[0]], list[objectiveDistribution[1]]]
end

def splitTerritories(list)
    territoriesDistribution = (0..(list.length - 1)).to_a.shuffle
    player1, player2 = territoriesDistribution.each_slice(territoriesDistribution.size/2).to_a
    newList = Array[]
    player1.map{|x| terr = list[x];newList.push(Territory.new(terr[:name], 1, terr[:troops], terr[:x], terr[:y]))}
    player2.map{|x| terr = list[x];newList.push(Territory.new(terr[:name], 2, terr[:troops], terr[:x], terr[:y]))}

    newList
end

def battle(attackTroops, defenseTroops)
    threads = []
    attackDices = []
    defenseDices = []
    numOfFights = [attackTroops - 1, defenseTroops, 3].min
    (0..[attackTroops - 1, 3].min).map{|x| threads << Thread.new do attackDices.push(1+rand(6));end}
    (0..[defenseTroops - 1, 3].min).map{|x| threads << Thread.new do defenseDices.push(1+rand(6));end}
    threads.map(&:join)

    attackDices.sort_by!{|x| -x}
    defenseDices.sort_by!{|x| -x}
    puts attackDices
    puts "-------"
    puts defenseDices

    (0..numOfFights-1).map{|x| puts attackDices[x] > defenseDices[x]}
end

# ENTER FUNCTIONALITIES
##################

def enter_showingObjectives
    if $turnPlayer == 1
        if $shownObj1
            $turnPlayer = 2
            #UPDATE UI SO THAT PLAYER 1 CLOSES HIS EYES
            puts "player1 close your eyes"
        else
            puts $listOfPlayers[0][:objective][:description]
            $shownObj1 = true
            #SHOWS PLAYER1 OBJ
        end
    elsif !$shownObj2
        puts $listOfPlayers[1][:objective][:description]
        $shownObj2 = true
    else
        $status = Constants::ORGANIZE_PHASE
        $turnPlayer = 1
        $availableTroops = getTroopsAvailable(1, $listOfTerritories)
    end
end

def enter_organize
    if $turnPlayer == 1
        if $availableTroops != 0
            #SHOW MUST EMPTY TROOPS
            puts "MUST EMPTY TROOPS PLAYER 1"
        else
            $turnPlayer = 2
            $availableTroops = getTroopsAvailable(2, $listOfTerritories)
        end
    else
        if $availableTroops != 0
            #SHOW MUST EMPTY TROOPS
            puts "MUST EMPTY TROOPS PLAYER 2"
        else
            updateTroops($listOfTerritories)
            $status = Constants::TROOP_PLACEMENT
            $turnPlayer = 1
            $availableTroops = getTroopsAvailable(1, $listOfTerritories)
        end
    end
end


def enter_troopPlacement
    if $availableTroops != 0
        # SHOW MUST EMPTY TROOPS
        puts "MUST EMPTY TROOPS FOR TROOP PLACEMENT PLAYER #{$turnPlayer}"
    else
        puts "PREPARE TO ATTACK"
        $status = Constants::ATTACK
    end
end

def enter_attack
    puts "MANAGE YOUR TROOPS PLAYER #{$turnPlayer}"
    $status = Constants::MANAGEMENT
end

# def ENTER_victoryManagement
#     if $conqueredTerritory[:troops] != 0
#         #SHOW MUST MOVE AT LEAST ONE TROOP
#     else
#         $status = Constants::ATTACK
#     end
# end

# def ENTER_management
#     $status = Constants::TROOP_PLACEMENT
#     $turnPlayer = changeTurn($turnPlayer)
# end

# def ENTER_finish
#     exit(0)
# end

######################## 
# CLICK FUNCTIONALITIES
########################

def click_organize(btn, typeOfClick)
    case [btn[:type], typeOfClick]
    when Qo["TERRITORY", Gosu::MsLeft] then $addTroop[1, btn[:name], $listOfTerritories, $territoryMinTroops[btn[:name]]]
    when Qo["TERRITORY", Gosu::MsRight] then $decTroop[1, btn[:name], $listOfTerritories, $territoryMinTroops[btn[:name]]]
    else $listOfTerritories
    end
end

def click_troopPlacement(btn, typeOfClick)
    case [btn[:type], typeOfClick]
    when Qo["TERRITORY", Gosu::MsLeft] then $addTroop[1, btn[:name], $listOfTerritories, $territoryMinTroops[btn[:name]]]
    when Qo["TERRITORY", Gosu::MsRight] then $decTroop[1, btn[:name], $listOfTerritories, $territoryMinTroops[btn[:name]]]
    else $listOfTerritories
    end
end

def click_attacker(btn, typeOfClick)
    attacker = ""
    case[typeOfClick]
    when Qo[Gosu::MsLeft] then selectAsAttacker(btn[:name], $turnPlayer, $listOfTerritories, $territoryButtons)
    else attacker
    end
end

def click_attacked(btn, typeOfClick)
    attacked = ""
    case [typeOfClick]
    when Qo[Gosu::MsLeft] then selectAsAttacked(btn[:name], $turnPlayer, $listOfTerritories)
    else attacked
    end
end

# def CLICK_victoryManagement(btn, typeOfClick)
#     case [btn[:name], typeOfClick]    
#     when Qo[$attacked, Gosu::MsLeft] then addTroop(1, $attacked, $listOfTerritories, $territoryMinTroops[btn[:name]])
#     when Qo[$attacked, Gosu::MsRight] then decTroop(1, $attacked, $listOfTerritories, $territoryMinTroops[btn[:name]])
#     when Qo[$attacker, Gosu::MsLeft] then addTroop(1, $attacker, $listOfTerritories, $territoryMinTroops[btn[:name]])
#     when Qo[$attacker, Gosu::MsRight] then decTroop(1, $attacker, $listOfTerritories, $territoryMinTroops[btn[:name]])
#     end
# end

# def CLICK_management(btn)
#     case [$selected]
#     when Qo[""] then $selected = btn[:name]
#     else transferTroops($selected, btn[:name])
# end

################


def eventDispatcher(btn, typeOfClick)
    case [typeOfClick]
    when Qo["ENTER"] then case [$status]
        when Qo[Constants::SHOWING_OBJECTIVES] then enter_showingObjectives
        when Qo[Constants::ORGANIZE_PHASE] then enter_organize
        when Qo[Constants::TROOP_PLACEMENT] then enter_troopPlacement
        when Qo[Constants::ATTACK] then enter_attack
        # when Qo[Constants::MANAGEMENT] then enter_management
        end
    else case [$status]
        when Qo[Constants::ORGANIZE_PHASE] then $listOfTerritories = click_organize(btn, typeOfClick)
        when Qo[Constants::TROOP_PLACEMENT] then $listOfTerritories = click_troopPlacement(btn, typeOfClick)
        when Qo[Constants::ATTACK] then $attacker == "" ? $attacker = click_attacker(btn, typeOfClick) : ($attacked = click_attacked(btn, typeOfClick);
                                                                                                          if $attacked != ""
                                                                                                            att = getTerritory($attacker, $listOfTerritories)
                                                                                                            defs = getTerritory($attacked, $listOfTerritories)
                                                                                                            resultAtt = att[:troops]
                                                                                                            resultDefs = defs[:troops]
                                                                                                            battle(att[:troops], defs[:troops]).map{|bat| bat ? $listOfTerritories = $decTroop[1, $attacked, $listOfTerritories, -1]
                                                                                                                                                                : $listOfTerritories = $decTroop[1, $attacker, $listOfTerritories, 1]}
                                                                                                            # newAtt = Territory.new(att[:name], resultAtt, att[:playerId], att[:x], att[:y])
                                                                                                            # newDefs = Territory.new(defs[:name], resultDefs, defs[:playerId], defs[:x], defs[:y])
                                                                                                            # $listOfTerritories = updateTerritories(newAtt, updateTerritories(newDefs, $listOfTerritories))
                                                                                                          end)
        end
    end
end


startGame
eventDispatcher(nil, "ENTER")
eventDispatcher(nil, "ENTER")
eventDispatcher(nil, "ENTER")
eventDispatcher(nil, "ENTER")

eventDispatcher(nil, "ENTER")
puts $availableTroops
10.times do eventDispatcher(Button.new("TERRITORY", "China", nil, nil), Gosu::MsLeft);end
puts $availableTroops
eventDispatcher(nil, "ENTER")
$availableTroops = 0
eventDispatcher(nil, "ENTER")
10.times do eventDispatcher(Button.new("TERRITORY", "China", nil, nil), Gosu::MsLeft);end
puts $availableTroops
eventDispatcher(nil, "ENTER")

$listOfTerritories.map!{|x| x[:name] == "China" ? Territory.new(x[:name], 1, x[:troops], x[:x], x[:y]) : x}
$listOfTerritories.map!{|x| x[:name] == "Mongolia" ? Territory.new(x[:name], 2, x[:troops], x[:x], x[:y]) : x}

puts getTerritory("China", $listOfTerritories)[:troops]
puts getTerritory("Mongolia", $listOfTerritories)[:troops]
eventDispatcher(Button.new("TERRITORY", "China", nil, nil), Gosu::MsLeft)
puts $attacker
eventDispatcher(Button.new("TERRITORY", "Mongolia", nil, nil), Gosu::MsLeft)
puts $attacked
puts getTerritory("China", $listOfTerritories)[:troops]
puts getTerritory("Mongolia", $listOfTerritories)[:troops]
eventDispatcher(nil, "ENTER")