class Player
    
    def initialize(name, color)
        @name, @color = name, color
        @territories = []
    end

    def getName; @name end
    def getColor; @color end
    def getTerritories; @territories end

    def addTerritory(territory); @territories.push(territory) end
    def removeTerritory(territory); @territories.select!{|x| x != territory} end
   
end