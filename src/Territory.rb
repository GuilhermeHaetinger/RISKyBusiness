require 'ruby2d'

class Territory
        
  def initialize(name, neighbors, mapPosition)
      @name, @neighbors, @mapPosition = name, neighbors, mapPosition
  end

  def show()
    x = @mapPosition[0]
    y = @mapPosition[1]
    @rect = Quad.new(
      x1: x,
      y1: y, 
      x2: x+50, 
      y2: y, 
      x3: x+50, 
      y3: y+50, 
      x4: x, 
      y4: y+50,
      z: 1,
      color: 'black'
      )
  end

  def getName; @neighbors end
  def getNeighbors; @neighbors end
  def getMapPosition; @mapPosition end
  def addNeighbor(neighbor)
    @neighbors.push(neighbor)
  end
end