class Player
  def initialize(name, id, objective)
    @objective = objective
    @name = name
    @troopsAvailable = 10
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

  def decreaseTroops(amount)
    @troopsAvailable -= amount
  end

  def increaseTroops(amount)
    @troopsAvailable += amount
  end

  def getObjective()
    @objective
  end

  def isWinner()
    @objective.isObjectiveFulfilled(@id)
  end
end