$LOAD_PATH << '.'
require 'Army'
class Tank < Army

    def generateAttack()
        1 + rand(5)
    end

    def generateDefence()
        1 + rand(8)
    end

    def battleCry()
        "KABUMMMMMMMMMM"
    end

    def getCost()
        3
    end
end
