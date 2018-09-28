$LOAD_PATH << '.'
require 'Army'
class Jetplane < Army

    def generateAttack()
        1 + rand(7)
    end

    def generateDefence()
        1 + rand(5)
    end

    def battleCry()
        "VUMMMMMMMMMMMMMMMMMMM"
    end

    def getCost()
        5
    end
end
