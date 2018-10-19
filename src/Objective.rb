$LOAD_PATH << '.'

require 'singleton'
require 'Objective'
require './modules/Interface'

class Objective
  include Interface
  def initialize(name)
    @name = name
  end

  def isObjectiveFulfilled(playerId)
    Objective.api_not_implemented(self)
  end

  def getName()
    @name
  end
end