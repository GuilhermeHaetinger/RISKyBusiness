$LOAD_PATH << '.'
require 'Army'
class Battalion < Army

    def generateAttack()
        1 + rand(6)
    end

    def generateDefence()
        1 + rand(6)
    end

    def battleCry()
        "AAAAAAAAAAAAA"
    end

    def getCost()
        1
    end
end
