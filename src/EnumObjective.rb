module EnumObjective

    ELIMINATE_BLUE = :eliminate_blue
    ELIMINATE_BLACK = :eliminate_black
    ELIMINATE_RED = :eliminate_red
    ELIMINATE_GREEN = :eliminate_green

    CONQUER_24 = :conquer_24

    CONQUER_ASIA_SOUTHAMERICA = :conquer_asia_southamerica

    def listObjectives 
        [ELIMINATE_BLUE, ELIMINATE_BLACK, ELIMINATE_RED, ELIMINATE_GREEN, CONQUER_24, CONQUER_ASIA_SOUTHAMERICA]
    end
    
    def getAndRemoveRandomObjective(listOfObjectives)
        randIndex = rand(listOfObjectives.length)
        randomObjective = listOfObjectives[randIndex]
        newList = listOfObjectives.remove(randIndex)
        [randomObjective, newList]
    end

end
