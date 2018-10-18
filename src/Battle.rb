$LOAD_PATH << '.'

require 'Player'
require 'Territory'
require 'Game'

class Battle
    def initialize(game, attack, defense)
        @attack = attack
        @defense = defense
    end

    def fight()
        numOfFights = [@attack.getNumOfTroops() - 1, @defense.getNumOfTroops(), 3].min
        attackDices = []
        [@attack.getNumOfTroops()- 1, 3].min.times do |_|
            attackDices.push(1 + rand(6))
        end
        attackDices.sort_by!{|x| -x}
        defenseDices = []
        [@defense.getNumOfTroops(), 3].min.times do |_|
            defenseDices.push(1 + rand(6))
        end
        defenseDices.sort_by!{|x| -x}
        numOfFights.times do |n|
            if attackDices[n] > defenseDices[n]
                @defense.decreaseTroops(1)
            else
                @attack.decreaseTroops(1)
            end
        end
        puts "attack = #{attackDices}"
        puts "defense = #{defenseDices}"
    end

    def getAttack()
        @attack
    end

    def getDefense()
        @defense
    end
end