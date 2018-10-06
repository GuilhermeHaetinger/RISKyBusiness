class Territories
    
    def initialize
        @@territories = {}
        addTerritory("test", [], [100, 200])
        addTerritory("test1", [], [100, 300])
        addTerritory("test2", [], [300, 200])
        addTerritory("test3", [], [140, 200])
    end

    private def addTerritory(name, neighbors, mapPosition)
        territory = Territory.new(name, neighbors, mapPosition)
        @@territories[name.to_sym] = territory
    end

    def self.getTerritory(name)
        @@territories[name]
    end

    def self.getTerritories
        @@territories.keys
    end

    class Territory
        
        def initialize(name, neighbors, mapPosition)
            @name, @neighbors, @mapPosition = name, neighbors, mapPosition
        end

        def getName; @neighbors end
        def getNeighbors; @neighbors end
        def getMapPosition; @mapPosition end
    end
end