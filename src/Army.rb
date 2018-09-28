$LOAD_PATH << '.'
require 'AbstractInterface'
class Army
    include AbstractInterface

    def generateAttack()
      Army.api_not_implemented(self)
    end
  
    def generateDefence()
        Army.api_not_implemented(self)
    end
  
    def battleCry()
        Army.api_not_implemented(self)
    end

    def getCost()
        Army.api_not_implemented(self)
    end
end  