$LOAD_PATH << '.'

require 'gosu'
require 'qo'
require './Modules/constants.rb'
require './Modules/zorder.rb'

Player = Struct.new(:id, :objective)
Territory = Struct.new(:name, :playerId, :troops, :x, :y)
Button = Struct.new(:type, :name, :image, :x, :y)
Objective = Struct.new(:description, :function)

$turnPlayer = nil
$listOfPlayers = Array.new
$listOfTerritories = Array.new
$mapOfAdjacence = Hash.new
$continents = Hash.new
$objectives = Array.new
$menuButtons = Array.new
$territoryButtons = Array.new
$status = Constants::MENU
$shownObj1 = false
$shownObj2 = false
$availableTroops = nil
$conqueredTerritory = nil

$attacker = ""
$attacked = ""
$selected = ""

$territoryMinTroops = Hash.new
$territoryMovedTroops = Hash.new

$text = nil
$subtext = nil

def head(list) list.to_a[0];end
def tail(list) list.to_a[1..-1];end

def initTexts
    h1 = Gosu::Font.new(45)
    p = Gosu::Font.new(30)
    [h1, p]
end

def initMenuButtons
    menuButtons = Array.new
    menuButtons.push(Button.new("MENU", "PLAY", Gosu::Image.new('../assets/img/PLAY.png', false), 500, 510))
    menuButtons.push(Button.new("MENU", "EXIT", Gosu::Image.new('../assets/img/EXIT.png', false), 500, 590))
    menuButtons
end

def initTerritoryButtons(listOfTerritories)
    listOfTerritories.map{|x| image = (x[:playerId] == 1 ? Constants::PLAYER1_IMAGE : Constants::PLAYER2_IMAGE);
                                      Button.new("TERRITORY", x[:name], image, x[:x], x[:y])
                         }
end

def initTerritoryList
    listOfTerritories = Array.new
    listOfTerritories.push(Territory.new("Chile", nil, 1, 211, 478)) # Chile
    listOfTerritories.push(Territory.new("Venezuela", nil, 1, 254, 393)) # Venezuela
    listOfTerritories.push(Territory.new("Argentina", nil, 1, 286, 592)) # Argentina
    listOfTerritories.push(Territory.new("Brazil", nil, 1, 399, 481)) # Brazil
    listOfTerritories.push(Territory.new("Mexico", nil, 1, 200, 320)) # Mexico
    listOfTerritories.push(Territory.new("Eastern US", nil, 1, 270, 250)) # Eastern US
    listOfTerritories.push(Territory.new("Western US", nil, 1, 170, 235)) # Western US
    listOfTerritories.push(Territory.new("Quebec", nil, 1, 350, 180)) # Quebec
    listOfTerritories.push(Territory.new("Ontario", nil, 1, 275, 170)) # Ontario
    listOfTerritories.push(Territory.new("Alberta", nil, 1, 180, 160)) # Alberta
    listOfTerritories.push(Territory.new("Alaska", nil, 1, 50, 100)) # Alaska
    listOfTerritories.push(Territory.new("Northwest Territory", nil, 1, 170, 90)) # Northwest Territory
    listOfTerritories.push(Territory.new("Greenland", nil, 1, 470, 55)) # Greenland
    listOfTerritories.push(Territory.new("Iceland", nil, 1, 500, 120)) # Iceland
    listOfTerritories.push(Territory.new("Britain", nil, 1, 485, 200)) # Britain
    listOfTerritories.push(Territory.new("Western EU", nil, 1, 475, 270)) # Western EU
    listOfTerritories.push(Territory.new("North EU", nil, 1, 570, 210)) # North EU
    listOfTerritories.push(Territory.new("South EU", nil, 1, 590, 280)) # South EU
    listOfTerritories.push(Territory.new("Scandinavia", nil, 1, 600, 100)) # Scandinavia
    listOfTerritories.push(Territory.new("Ukraine", nil, 1, 690, 150)) # Ukraine
    listOfTerritories.push(Territory.new("Afghanistan", nil, 1, 795, 235)) # Afghanistan
    listOfTerritories.push(Territory.new("Ural", nil, 1, 810, 130)) # Ural
    listOfTerritories.push(Territory.new("Siberia", nil, 1, 900, 110)) # Siberia
    listOfTerritories.push(Territory.new("Yakursk", nil, 1, 1025, 100)) # Yakursk
    listOfTerritories.push(Territory.new("Kamtchatka", nil, 1, 1150, 110)) # Kamtchatka
    listOfTerritories.push(Territory.new("Irkutsk", nil, 1, 990, 170)) # Irkutsk
    listOfTerritories.push(Territory.new("Mongolia", nil, 1, 1020, 230)) # Mongolia
    listOfTerritories.push(Territory.new("Japan", nil, 1, 1100, 250)) # Japan
    listOfTerritories.push(Territory.new("China", nil, 1, 920, 280)) # China
    listOfTerritories.push(Territory.new("Middle", nil, 1, 725, 350)) # Middle East
    listOfTerritories.push(Territory.new("India", nil, 1, 850, 390)) # India
    listOfTerritories.push(Territory.new("Siam", nil, 1, 950, 370)) # Siam
    listOfTerritories.push(Territory.new("Indonesia", nil, 1, 920, 460)) # Indonesia
    listOfTerritories.push(Territory.new("New Guinea", nil, 1, 1150, 480)) # New Guinea
    listOfTerritories.push(Territory.new("Eastern Australia", nil, 1, 1100, 550)) # Eastern Australia
    listOfTerritories.push(Territory.new("Western Australia", nil, 1, 970, 580)) # Western Australia
    listOfTerritories.push(Territory.new("North Africa", nil, 1, 502, 390)) # North Africa
    listOfTerritories.push(Territory.new("South Africa", nil, 1, 588, 617)) # South Africa
    listOfTerritories.push(Territory.new("Central Africa", nil, 1, 606, 495)) # Central Africa
    listOfTerritories.push(Territory.new("Egypt", nil, 1, 633, 362)) # Egypt
    listOfTerritories.push(Territory.new("East Africa", nil, 1, 702, 463)) # East Africa
    listOfTerritories.push(Territory.new("Madagascar", nil, 1, 712, 580)) # Madagascar
    listOfTerritories
end

def resetMovedTroops(listOfTerritories)
    movedTroops = Hash.new
    listOfTerritories.map{|x| movedTroops[x[:name]] = 0}
    movedTroops
end

def initMinTroops(listOfTerritories)
    territoryMinTroops = Hash.new
    listOfTerritories.map {|x| territoryMinTroops[x[:name]] = 1}
    territoryMinTroops
end

def initMapOfAdjacence
    mapOfAdjacence = Hash.new
    mapOfAdjacence["Chile"]               = Array["Venezuela", "Argentina", "Brazil"]
    mapOfAdjacence["Venezuela"]           = Array["Chile", "Brazil", "Mexico"]
    mapOfAdjacence["Argentina"]           = Array["Chile", "Brazil"]
    mapOfAdjacence["Brazil"]              = Array["Chile", "Venezuela", "Argentina"]
    mapOfAdjacence["Mexico"]              = Array["Venezuela", "Western US", "Eastern US"]
    mapOfAdjacence["Eastern US"]          = Array["Western US", "Mexico", "Ontario", "Quebec"]
    mapOfAdjacence["Western US"]          = Array["Eastern US", "Mexico", "Alberta", "Ontario"]
    mapOfAdjacence["Quebec"]              = Array["Eastern US", "Ontario", "Greenland"]
    mapOfAdjacence["Ontario"]             = Array["Western US", "Eastern US", "Alberta", "Northwest Territory", "Quebec", "Greenland"]
    mapOfAdjacence["Alberta"]             = Array["Western US", "Ontario", "Northwest Territory", "Alaska"]
    mapOfAdjacence["Alaska"]              = Array["Northwest Territory", "Alberta", "Kamtchatka"]
    mapOfAdjacence["Northwest Territory"] = Array["Alaska", "Alberta", "Ontario", "Greenland"]
    mapOfAdjacence["Greenland"]           = Array["Northwest Territory", "Quebec", "Iceland"]
    mapOfAdjacence["Iceland"]             = Array["Greenland", "Britain", "Scandinavia"]
    mapOfAdjacence["Britain"]             = Array["Western EU", "Iceland", "Scandinavia", "North EU"]
    mapOfAdjacence["Western EU"]          = Array["North EU", "South EU", "Britain", "North Africa"]
    mapOfAdjacence["North EU"]            = Array["Britain", "Western EU", "South EU", "Ukraine"]
    mapOfAdjacence["South EU"]            = Array["Western EU", "North EU", "Ukraine", "Middle", "Egypt", "North Africa"]
    mapOfAdjacence["Scandinavia"]         = Array["Britain", "Iceland", "Ukraine"]
    mapOfAdjacence["Ukraine"]             = Array["Scandinavia", "North EU", "South EU", "Afghanistan", "Ural", "Middle"]
    mapOfAdjacence["Afghanistan"]         = Array["Ukraine", "Ural", "China", "India", "Middle"]
    mapOfAdjacence["Ural"]                = Array["Siberia", "Ukraine", "Afghanistan", "China"]
    mapOfAdjacence["Siberia"]             = Array["Ural", "China", "Yakursk", "Irkutsk", "Mongolia", "China"]
    mapOfAdjacence["Yakursk"]             = Array["Siberia", "Irkutsk", "Kamtchatka"]
    mapOfAdjacence["Kamtchatka"]          = Array["Alaska", "Japan", "Mongolia", "Irkutsk", "Yakursk"]
    mapOfAdjacence["Irkutsk"]             = Array["Siberia", "Yakursk", "Mongolia", "Kamtchatka"]
    mapOfAdjacence["Mongolia"]            = Array["Siberia", "Irkutsk", "China", "Kamtchatka", "Japan"]
    mapOfAdjacence["Japan"]               = Array["Mongolia", "Kamtchatka"]
    mapOfAdjacence["China"]               = Array["Mongolia", "Siberia", "Ural", "Afghanistan", "India", "Siam"]
    mapOfAdjacence["Middle"]              = Array["Egypt", "South EU", "Ukraine", "Afghanistan", "India", "East Africa"]
    mapOfAdjacence["India"]               = Array["Middle", "Afghanistan", "China", "Siam"]
    mapOfAdjacence["Siam"]                = Array["Indonesia", "India", "China"]
    mapOfAdjacence["Indonesia"]           = Array["Siam", "New Guinea", "Western Australia"]
    mapOfAdjacence["New Guinea"]          = Array["Eastern Australia", "Indonesia", "Western Australia"]
    mapOfAdjacence["Eastern Australia"]   = Array["Eastern Australia", "Indonesia", "Western Australia"]
    mapOfAdjacence["Western Australia"]   = Array["Eastern Australia", "Indonesia", "New Guinea"]
    mapOfAdjacence["North Africa"]        = Array["Central Africa", "Egypt", "East Africa", "Western EU", "South EU"]
    mapOfAdjacence["South Africa"]        = Array["Madagascar", "Central Africa", "East Africa"]
    mapOfAdjacence["Central Africa"]      = Array["North Africa", "East Africa", "South Africa"]
    mapOfAdjacence["Egypt"]               = Array["East Africa", "North Africa", "South EU", "Middle"]
    mapOfAdjacence["East Africa"]         = Array["Central Africa", "North Africa", "Egypt", "South Africa"]
    mapOfAdjacence["Madagascar"]          = Array["South Africa"]
    mapOfAdjacence
end

def initContinents
    continents = Hash.new
    continents["South America"] = Array["Chile", "Venezuela", "Argentina", "Brazil"]
    continents["North America"] = Array["Mexico", "Eastern US", "Western US", "Quebec", "Ontario", "Alberta", "Alaska", "Northwest Territory", "Greenland"]
    continents["Europe"]        = Array["Iceland", "Britain", "Western EU", "North EU", "South EU", "Scandinavia", "Ukraine"]
    continents["Asia"]          = Array["Afghanistan", "Ural", "Siberia", "Yakursk", "Kamtchatka", "Irkutsk", "Mongolia", "Japan", "China", "Middle", "India", "Siam"]
    continents["Oceania"]       = Array["Indonesia", "New Guinea", "Eastern Australia", "Western Australia"]
    continents["Africa"]        = Array["North Africa", "South Africa", "Central Africa", "Egypt", "East Africa", "Madagascar"]
    continents
end

def initObjectives(continents)
    territories32 = lambda {|id, listOfTerritories| (listOfTerritories.select{|x| x[:playerId] == id}).length >= 32}

    asiaANDafrica = lambda {|id, listOfTerritories| checkContinents(["Asia", "Africa"], id, continents, listOfTerritories)}
    oceaniaANDeuropeANDafrica = lambda {|id, listOfTerritories| checkContinents(["Oceania", "Europe", "Africa"], id, continents, listOfTerritories)}
    asiaANDeurope = lambda {|id, listOfTerritories| checkContinents(["Asia", "Europe"], id, continents, listOfTerritories)}
    northAmericaANDafrica = lambda {|id, listOfTerritories| checkContinents(["North America", "Africa"], id, continents, listOfTerritories)}
    southAmericaANDnorthAmericaANDoceania = lambda {|id, listOfTerritories| checkContinents(["South America", "North America", "Oceania"], id, continents, listOfTerritories)}
    asiaANDsouthAmerica = lambda {|id, listOfTerritories| checkContinents(["Asia", "South America"], id, continents, listOfTerritories)}

    objectives = Array.new
    objectives.push(Objective.new("32 Territories", territories32))
    objectives.push(Objective.new("Asia and Africa", asiaANDafrica))
    objectives.push(Objective.new("Oceania, Europe and Africa", oceaniaANDeuropeANDafrica))
    objectives.push(Objective.new("Asia and Europe", asiaANDeurope))
    objectives.push(Objective.new("North America and Africa", northAmericaANDafrica))
    objectives.push(Objective.new("South America, North America and Oceania", southAmericaANDnorthAmericaANDoceania))
    objectives.push(Objective.new("Asia and South America", asiaANDsouthAmerica))
    objectives
end

def startGame
    listOfTerritories = splitTerritories(initTerritoryList)
    mapOfAdjacence = initMapOfAdjacence
    territoryMinTroops = initMinTroops(listOfTerritories)
    territoryButtons = initTerritoryButtons(listOfTerritories)
    continents = initContinents
    objective1, objective2 = get2RandomObjectives(initObjectives(continents))
    player1 = Player.new(1, objective1)
    player2 = Player.new(2, objective2)
    listOfPlayers = [player1, player2]
    turnPlayer = 1
    status = Constants::SHOWING_OBJECTIVES
    h1, p = initTexts
    text =  "player 2 close your eyes"
    [text, status, false, false, turnPlayer, listOfTerritories, listOfPlayers, territoryMinTroops, territoryButtons, "", ""]
end

def changeTurn(id)
    id == 1 ? 2 : 1
end

def getSpecificAdjacentTerritories(boolOp, territory, mapOfAdjacence, territories)
    mapOfAdjacence[territory[:name]].select{|x| territory[:playerId].send(boolOp, getTerritory(x, territories)[:playerId])};
end

def changeTroops(op, n, territoryName, territories, min)
    territories.map{|x| (x[:name] == territoryName && x[:troops].send(op, n) >= min) ? (Territory.new(x[:name], x[:playerId], x[:troops].send(op, n), x[:x], x[:y])) : x}
end

# CURRIES
$getAdjacentAllies = method(:getSpecificAdjacentTerritories).to_proc.curry["=="]
$getAdjacentEnemies = method(:getSpecificAdjacentTerritories).to_proc.curry["!="]
$addTroop = method(:changeTroops).to_proc.curry["+"]
$decTroop = method(:changeTroops).to_proc.curry["-"]

def selectAsAttacker(territoryName, turnPlayer, territories, buttons, mapOfAdjacence)
    territory = getTerritory(territoryName, territories)
    territory[:playerId] == turnPlayer && territory[:troops] > 1 ? ([paintTroops(Constants::ATTACK_IMAGE, ($getAdjacentEnemies[territory, mapOfAdjacence, territories]), buttons),territoryName]) : [buttons, ""]
end

def selectAsSelected(territoryName, turnPlayer, territories, buttons, mapOfAdjance, listOfTerritories)
    territory = getTerritory(territoryName, territories)
    territory[:playerId] == turnPlayer ? ([paintTroops(Constants::MOVE_IMAGE, ($getAdjacentAllies[territory, mapOfAdjacence, listOfTerritories]), buttons),territoryName]) : [buttons, ""]
end

def selectAsAttacked(territoryName, turnPlayer, attacker, territories, mapOfAdjacence)
    territory = getTerritory(territoryName, territories)
    territory[:playerId] != turnPlayer && $getAdjacentEnemies[attacker, mapOfAdjacence, territories].include?(territoryName) ? territoryName : ""
end

def updateTroops(lisOfTerritories)
    newMinTroops = Hash.new
    lisOfTerritories.map{|x| newMinTroops[x[:name]] = x[:troops]}
    newMinTroops
end

def numOfTerritories(id, territories)
    territories.select{|x| x[:playerId] == id}.length
end

def checkContinents(contLs, id, continents, listOfTerritories)
    continents[head(contLs)].all?{|x| getTerritory(x, listOfTerritories)[:playerId] == id} && (contLs.length == 1 ? true : checkContinents(tail(contLs), id, continents, listOfTerritories))
end

def getTroopsAvailable(id, territories, continents)
    numOfTroops = numOfTerritories(id, territories) / 2
    numOfTroops += checkContinents(["South America"], id, continents, territories) ? 2 : 0
    numOfTroops += checkContinents(["North America"], id, continents, territories) ? 5 : 0
    numOfTroops += checkContinents(["Europe"], id, continents, territories) ? 5 : 0
    numOfTroops += checkContinents(["Oceania"], id, continents, territories) ? 2 : 0
    numOfTroops += checkContinents(["Africa"], id, continents, territories) ? 4 : 0
    numOfTroops += checkContinents(["Asia"], id, continents, territories) ? 7 : 0
    numOfTroops
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
    if territories.length != 0
        paintTroops(color, tail(territories), paintTroop(color, head(territories), buttons))
    else
        buttons
    end
end

def resetTroopColors(territories, buttons)
    buttons1 = paintTroops(Constants::PLAYER1_IMAGE, territories.map{|x| if x[:playerId] == 1 then x[:name]; end}, buttons)
    paintTroops(Constants::PLAYER2_IMAGE, territories.map{|x| if x[:playerId] == 2 then x[:name]; end}, buttons1)
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

    (0..numOfFights-1).map{|x| attackDices[x] > defenseDices[x]}
end

def transferTroops(selected, toTransfer, minTroops, movedTroops, territories, buttons)
    mov = movedTroops
    if movedTroops < minTroops then
        terr = $addTroop[1, toTransfer, territories, 1]
        newTerritories = $decTroop[1, selected, terr, 1]
        mov += 1
    end
    [mov, newTerritories, resetTroopColors(newTerritories, buttons)]
end

# ENTER FUNCTIONALITIES
##################

def enter_showingObjectives(listOfTerritories, listOfPlayers, shownObj1, shownObj2, turnPlayer, availableTroops, continents)
    shownObj1_ = shownObj1_
    shownObj2_ = shownObj2
    turnPlayer_ = turnPlayer
    availableTroops_ = availableTroops
    status_ = Constants::SHOWING_OBJECTIVES
    text = ""

    if turnPlayer == 1
        if shownObj1
            turnPlayer_ = 2
            text =  "player 1 close your eyes"
        else
            text = listOfPlayers[0][:objective][:description]
            shownObj1_ = true
        end
    elsif !shownObj2
        text = listOfPlayers[1][:objective][:description]
        shownObj2_ = true
    else
        status_ = Constants::ORGANIZE_PHASE
        turnPlayer_ = 1
        availableTroops_ = getTroopsAvailable(1, listOfTerritories, continents)
    end

    [text, shownObj1_, shownObj2_, turnPlayer_, availableTroops_, status_]
end

def enter_organize(listOfTerritories, turnPlayer, availableTroops, continents, minTroops)
    turnPlayer_ = turnPlayer
    availableTroops_ = availableTroops
    minTroops_ = minTroops
    status_ = Constants::ORGANIZE_PHASE
    text = ""

    if turnPlayer == 1
        if availableTroops != 0
            text = "MUST EMPTY TROOPS PLAYER 1"
        else
            turnPlayer_ = 2
            availableTroops_ = getTroopsAvailable(2, listOfTerritories, continents)
        end
    else
        if availableTroops != 0
            text = "MUST EMPTY TROOPS PLAYER 2"
        else
            minTroops_ = updateTroops(listOfTerritories)
            status_ = Constants::TROOP_PLACEMENT
            turnPlayer_ = 1
            availableTroops_ = getTroopsAvailable(1, listOfTerritories, continents)
        end
    end

    [text, turnPlayer_, availableTroops_, status_, minTroops_]
end

def enter_troopPlacement(turnPlayer, availableTroops)
    status_ = Constants::TROOP_PLACEMENT
    text = ""
    if availableTroops != 0
        text = "MUST EMPTY TROOPS PLAYER #{turnPlayer}"
    else
        text = "PREPARE TO ATTACK"
        status_ = Constants::ATTACK
    end
    [text, status_]
end

def enter_attack(listOfTerritories, territoryButtons, turnPlayer, listOfPlayers)
    minTroops_ = updateTroops(listOfTerritories)
    territoryButtons_ = resetTroopColors(listOfTerritories, territoryButtons)
    territoryMovedTroops_ = resetMovedTroops(listOfTerritories)
    status_ = Constants::ATTACK
    text = ""
    text = "MANAGE YOUR TROOPS PLAYER #{turnPlayer}"
    status_ = Constants::MANAGEMENT
    if listOfPlayers[turnPlayer-1][:objective][:function].call(turnPlayer, listOfTerritories) then
        text = "PLAYER #{turnPlayer} WON!!"
        status_ = Constants::GAME_FINISHED
    end

    [text, minTroops_, territoryButtons_, territoryMovedTroops_, status_]
end

def enter_victoryManagement(listOfTerritories, attacked, attacker, territoryButtons)
    attacker_ = attacker
    territoryButtons_ = territoryButtons
    status_ = Constants::VICTORY_MANAGEMENT
    text = ""
    if getTerritory(attacked, listOfTerritories)[:troops] == 0
        text = "AT LEAST ONE TROOP"
    else
        attacker_ = ""
        territoryButtons_ = resetTroopColors(listOfTerritories, territoryButtons)
        status_ = Constants::ATTACK
    end

    [text, attacker_, territoryButtons_, status_]
end

def enter_management(listOfTerritories, turnPlayer, availableTroops, continents)
    minTroops_ = updateTroops(listOfTerritories)
    status_ = Constants::TROOP_PLACEMENT
    turnPlayer_ = changeTurn(turnPlayer)
    availableTroops_ = getTroopsAvailable(turnPlayer_, listOfTerritories, continents)
    text = "PLAYER #{turnPlayer_} TURN"

    [text, minTroops_, status_, turnPlayer_, availableTroops_]
end

######################## 
# CLICK FUNCTIONALITIES
########################

def click_organize(btn, typeOfClick, availableTroops, listOfTerritories, territoryMinTroops)
    case [btn[:type], typeOfClick]
    when Qo["TERRITORY", Gosu::MsLeft] then availableTroops > 0 ? 
        (availableTroops -= 1;
         [availableTroops, $addTroop[1, btn[:name],
          listOfTerritories,
          territoryMinTroops[btn[:name]]]]) : 
        [availableTroops, listOfTerritories]
    when Qo["TERRITORY", Gosu::MsRight] then buffer = getTerritory(btn[:name], listOfTerritories)[:troops];
                                             newList = $decTroop[1, btn[:name], listOfTerritories, territoryMinTroops[btn[:name]]];
                                             if buffer > getTerritory(btn[:name], newList)[:troops] then availableTroops += 1;end;
                                             [availableTroops, newList]
    else [availableTroops, listOfTerritories]
    end
end

def click_attacker(btn, typeOfClick, turnPlayer, listOfTerritories, territoryButtons, mapOfAdjacence)
    attacker = ""
    case[typeOfClick]
    when Qo[Gosu::MsLeft] then selectAsAttacker(btn[:name], turnPlayer, listOfTerritories, territoryButtons, mapOfAdjacence)
    else [territoryButtons, attacker]
    end
end

def click_attacked(btn, typeOfClick, turnPlayer, attacker, listOfTerritories, mapOfAdjacence)
    attacked = ""
    case [typeOfClick]
    when Qo[Gosu::MsLeft] then selectAsAttacked(btn[:name], turnPlayer, getTerritory(attacker, listOfTerritories), listOfTerritories, mapOfAdjacence)
    else attacked
    end
end

def click_victoryManagement(btn, typeOfClick, attacked, attacker, listOfTerritories)
    case [btn[:name], typeOfClick]    
    when Qo[attacked, Gosu::MsLeft] then getTerritory(attacked, listOfTerritories)[:troops] < 3 && getTerritory(attacker, listOfTerritories)[:troops] > 1 ?
        $decTroop[1, attacker, $addTroop[1, attacked, listOfTerritories, 0], 1] : listOfTerritories

    when Qo[attacked, Gosu::MsRight] then getTerritory(attacked, listOfTerritories)[:troops] > 0 ?
        $addTroop[1, attacker, $decTroop[1, attacked, listOfTerritories, 0], 1] : listOfTerritories

    when Qo[attacker, Gosu::MsLeft] then getTerritory(attacked, listOfTerritories)[:troops] > 0 ?
        $addTroop[1, attacker, $decTroop[1, attacked, listOfTerritories, 0], 1] : listOfTerritories
    
    when Qo[attacker, Gosu::MsRight] then getTerritory(attacked, listOfTerritories)[:troops] < 3 && getTerritory(attacker, listOfTerritories)[:troops] > 1 ?
        $decTroop[1, attacker, $addTroop[1, attacked, listOfTerritories, 0], 1] : listOfTerritories
    else listOfTerritories
    end
end

def click_management(btn, buttons, selected, listOfTerritories, territoryMovedTroops, territoryMinTroops, mapOfAdjacence)
    case [selected]
    when Qo[""] then territory = getTerritory(btn[:name], listOfTerritories); (territoryMovedTroops[btn[:name]] < territoryMinTroops[btn[:name]] && territory[:troops] > 1) ? 
                                                                                    (selected = btn[:name];
                                                                                     [selected, 
                                                                                      territoryMovedTroops[selected],
                                                                                      listOfTerritories, 
                                                                                      paintTroops(Constants::MOVE_IMAGE, ($getAdjacentAllies[territory, mapOfAdjacence, listOfTerritories]), buttons)
                                                                                     ]) :
                                                                                     [selected, territoryMovedTroops[selected], listOfTerritories, buttons]
    when Qo[Any] then [selected].concat(transferTroops(selected, btn[:name], territoryMinTroops[selected], territoryMovedTroops[selected], listOfTerritories, buttons))
    end
end

################

def runAttack(listOfTerritories, territoryButtons, attacker, attacked, status, turnPlayer, btn)
    attacker_ = attacker
    listOfTerritories_ = listOfTerritories
    territoryButtons_ = territoryButtons
    status_ = status
    if attacked != "" && btn[:name] == attacked
        att = getTerritory(attacker, listOfTerritories)
        defs = getTerritory(attacked, listOfTerritories)
        resultAtt = att[:troops]
        resultDefs = defs[:troops]
        battle(att[:troops], defs[:troops]).map{|bat| bat ? listOfTerritories_ = $decTroop[1, attacked, listOfTerritories_, -1]
                                                            : listOfTerritories_ = $decTroop[1, attacker, listOfTerritories_, 1]}
        attackedTerr = getTerritory(attacked, listOfTerritories_)
        if attackedTerr[:troops] == 0 then 
            listOfTerritories_ = updateTerritories(Territory.new(attacked, turnPlayer, 0, attackedTerr[:x], attackedTerr[:y]), listOfTerritories);
            territoryButtons_ = resetTroopColors(listOfTerritories, territoryButtons)
            territoryButtons_ = paintTroop(Constants::MOVE_IMAGE, attacked, territoryButtons);
            status_ = Constants::VICTORY_MANAGEMENT
        else
            territoryButtons_ = resetTroopColors(listOfTerritories, territoryButtons)
            attacker_ = ""
        end 
    else
        territoryButtons_ = resetTroopColors(listOfTerritories, territoryButtons)
        attacker_ = ""
    end
    [attacker_, listOfTerritories_, territoryButtons_, status_]
end

def runManagement(listOfTerritories, turnPlayer, selected, territoryMovedTroops, territoryButtons, territoryMinTroops, mapOfAdjacence, btn)
    listOfTerritories_ = listOfTerritories
    selected_ = selected
    territoryButtons_ = territoryButtons
    territoryMovedTroops_ = territoryMovedTroops
    if getTerritory(btn[:name], listOfTerritories)[:playerId] == turnPlayer then
        if selected != btn[:name] then
            prevSelected = selected
            selected_, moved, ls, btns = click_management(btn, territoryButtons, selected, listOfTerritories, territoryMovedTroops, territoryMinTroops, mapOfAdjacence)
            listOfTerritories_ = ls; 
            territoryMovedTroops_[selected] = moved
            if prevSelected != ""
                selected_ = ""
            end
            territoryButtons_ = btns
        else
            selected_ = ""
            territoryButtons_ = resetTroopColors(listOfTerritories, territoryButtons)
        end
    end
    [listOfTerritories_, selected_, territoryButtons_, territoryMovedTroops_]
end

def eventDispatcher(status, shownObj1, shownObj2, turnPlayer, availableTroops, listOfTerritories, listOfPlayers, continents, territoryMinTroops, territoryMovedTroops, territoryButtons, mapOfAdjacence, attacked, attacker, btn, typeOfClick)
    text = ""
    status_ = status
    shownObj1_ = shownObj1
    shownObj2_ = shownObj2
    listOfTerritories_ = listOfTerritories
    listOfPlayers_ = listOfPlayers
    availableTroops_ = availableTroops
    territoryMinTroops_ = territoryMinTroops
    territoryMovedTroops_ = territoryMovedTroops
    territoryButtons_ = territoryButtons
    turnPlayer_ = turnPlayer
    attacker_ = attacker
    attacked_ = attacked
    case [typeOfClick, status]
        when Qo[Gosu::KB_RETURN, Constants::SHOWING_OBJECTIVES] then 
            text, shownObj1_, shownObj2_, turnPlayer_, availableTroops_, status_ = enter_showingObjectives(listOfTerritories, listOfPlayers, shownObj1, shownObj2, turnPlayer, availableTroops, continents)
        when Qo[Gosu::KB_RETURN, Constants::ORGANIZE_PHASE] then
            text, turnPlayer_, availableTroops_, status_, territoryMinTroops_ = enter_organize(listOfTerritories, turnPlayer, availableTroops, continents, territoryMinTroops)
        when Qo[Gosu::KB_RETURN, Constants::TROOP_PLACEMENT] then
            text, status_ = enter_troopPlacement(turnPlayer, availableTroops)
        when Qo[Gosu::KB_RETURN, Constants::ATTACK] then
            text, territoryMinTroops_, territoryButtons_, territoryMovedTroops_, status_ = enter_attack(listOfTerritories, territoryButtons, turnPlayer, listOfPlayers)
        when Qo[Gosu::KB_RETURN, Constants::VICTORY_MANAGEMENT] then
            text, attacker_, territoryButtons_, status_ = enter_victoryManagement(listOfTerritories, attacked, attacker, territoryButtons)
        when Qo[Gosu::KB_RETURN, Constants::MANAGEMENT] then 
            text, territoryMinTroops_, status_, turnPlayer_, availableTroops_ = enter_management(listOfTerritories, turnPlayer, availableTroops, continents)
        
        when Qo[Any, Constants::ORGANIZE_PHASE] then availableTroops_, listOfTerritories_ = getTerritory(btn[:name], listOfTerritories)[:playerId] == turnPlayer ? 
                                                                        click_organize(btn, typeOfClick, availableTroops, listOfTerritories, territoryMinTroops) :
                                                                        [availableTroops, listOfTerritories]
        when Qo[Any, Constants::TROOP_PLACEMENT] then availableTroops_, listOfTerritories_ = getTerritory(btn[:name], listOfTerritories)[:playerId] == turnPlayer ?
                                                                        click_organize(btn, typeOfClick, availableTroops, listOfTerritories, territoryMinTroops) :
                                                                        [availableTroops, listOfTerritories]
        when Qo[Any, Constants::ATTACK] then attacker == "" ? 
            (territoryButtons_, attacker_ = click_attacker(btn, typeOfClick, turnPlayer, listOfTerritories, territoryButtons, mapOfAdjacence)) : 
            (attacked_ = click_attacked(btn, typeOfClick, turnPlayer, attacker, listOfTerritories, mapOfAdjacence);
                attacker_, listOfTerritories_, territoryButtons_, status_ = runAttack(listOfTerritories, territoryButtons, attacker, attacked_, status, turnPlayer, btn)
            )
        when Qo[Any, Constants::VICTORY_MANAGEMENT] then listOfTerritories_ =  click_victoryManagement(btn, typeOfClick, attacked, attacker, listOfTerritories)
        when Qo[Any, Constants::MANAGEMENT] then listOfTerritories_, selected_, territoryButtons_, territoryMovedTroops_ = runManagement(listOfTerritories, turnPlayer, selected, territoryMovedTroops, territoryButtons, territoryMinTroops, mapOfAdjacence, btn)
    
    end
    [text, status_, shownObj1_, shownObj2_, turnPlayer_, listOfTerritories_, listOfPlayers_, territoryMinTroops_, territoryButtons_, attacked_, attacker_]
end

## UI

def drawCursor(window)
    Gosu::Image.new("../assets/img/cursor.png", false).draw(window.mouse_x, window.mouse_y, ZOrder::CURSOR)
end

def drawMenu(window, menuButtons)
    Gosu::Image.new("../assets/img/main_bg.jpg", tileable: true).draw(0, 0, ZOrder::BACKGROUND)
    menuButtons.map{|x| x[:image].draw(x[:x], x[:y], ZOrder::UI)}
end

def drawGame(window, territories, territoryButtons)
    Gosu::Image.new('../assets/img/MAP.jpg', false).draw(0, 0, ZOrder::BACKGROUND)
    font = Gosu::Font.new(40)
    territoryButtons.map{|x| font.draw_text("#{getTerritory(x[:name], territories)[:troops]}", x[:x]+15, x[:y]+15, ZOrder::SPRITES, 1.0, 1.0, Gosu::Color::YELLOW) 
                             ; x[:image].draw(x[:x], x[:y], ZOrder::SPRITES)}
end

def draw_(window, status, territories, territoryButtons, menuButtons, text, subtext)
    drawCursor(window)
    case [status]
    when Qo[Constants::MENU] then drawMenu(window, menuButtons)
    when Qo[Any] then
        drawGame(window, territories, territoryButtons);
        h1 = Gosu::Font.new(45)
        p = Gosu::Font.new(30)
        h1.draw_text("#{text}", 630, 675, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE);
        p.draw_text("#{subtext}", 750, 675, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE);
    end
end

def isMouseHovering(btn, window)
    mx = window.mouse_x
    my = window.mouse_y

    (mx >= btn[:x] and my >= btn[:y]) and (mx <= btn[:x] + btn[:image].width) and (my <= btn[:y] + btn[:image].height)
end

def isMouseClick(id)
    (id == Gosu::MsLeft || id == Gosu::MsRight) ? true : false
end

def clicked(window, id, menuButtons, status, shownObj1, shownObj2, turnPlayer, availableTroops, listOfTerritories, listOfPlayers, continents, territoryMinTroops, territoryMovedTroops, territoryButtons, mapOfAdjacence, attacked, attacker)
    if isMouseClick(id) then
        if status == Constants::MENU then
            if isMouseHovering(menuButtons[0], window) then
                return startGame
        elsif isMouseHovering(menuButtons[1], window) then
                exit()
            end
        else
            filter = territoryButtons.select{|x| isMouseHovering(x, window)}
            filter == [] ? nil : (return eventDispatcher(status, shownObj1, shownObj2, turnPlayer, availableTroops, listOfTerritories, listOfPlayers, continents, territoryMinTroops, territoryMovedTroops, territoryButtons, mapOfAdjacence, attacked, attacker, filter[0], id))
        end
    elsif id == Gosu::KB_RETURN
        return eventDispatcher(status, shownObj1, shownObj2, turnPlayer, availableTroops, listOfTerritories, listOfPlayers, continents, territoryMinTroops, territoryMovedTroops, territoryButtons, mapOfAdjacence, attacked, attacker, nil, id)
    else
        ["", status, shownObj1, shownObj2, turnPlayer, listOfTerritories, listOfPlayers, territoryMinTroops, territoryButtons, attacked, attacker]
    end
end

class Main < Gosu::Window  
    def initialize() super(Constants::WINDOW_WIDTH, Constants::WINDOW_HEIGHT); self.caption = 'RISKyBusiness'; $menuButtons = initMenuButtons end
    def draw () draw_(self, $status, $listOfTerritories, $territoryButtons, $menuButtons, $text, $subtext); end
    def button_down (id)
        $text, $status, $shownObj1, $shownObj2, $turnPlayer, $listOfTerritories, $listOfPlayers, $territoryMinTroops, $territoryButtons, $attacked, $attacker = 
            clicked(self, id, $menuButtons, $status, $shownObj1, $shownObj2, $turnPlayer, $availableTroops, $listOfTerritories, $listOfPlayers, $continents, $territoryMinTroops, $territoryMovedTroops, $territoryButtons, $mapOfAdjacence, $attacked, $attacker); end
end

Main.new.show