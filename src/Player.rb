class Player
  def initialize(name, id)
    @name = name
    @troopsAvailable = 25
    @score = 0
    @id = id
  end

  def getScore()
    return @score
  end

  def getName()
    return @name
  end

  def getTroopsAvailable()
    return @troopsAvailable
  end

  def getId()
    return @id
  end

  def decreaseTroops()
    @troopsAvailable -= 1
  end
end