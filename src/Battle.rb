$LOAD_PATH << '.'

require 'thread'
require 'Player'
require 'Territory'
require 'Game'

class Battle
    def initialize(game, attack, defense)
        @attack = attack
        @defense = defense
    end

    def fight()
        threads = []
        attackDices = []
        defenseDices = []

        numOfFights = [@attack.getNumOfTroops() - 1, @defense.getNumOfTroops(), 3].min
        
        [@attack.getNumOfTroops()- 1, 3].min.times do |_|
            threads << Thread.new do
                attackDices.push(1 + rand(6))
            end
        end
        
        [@defense.getNumOfTroops(), 3].min.times do |_|
            threads << Thread.new do
                defenseDices.push(1 + rand(6))
            end
        end

        threads.map(&:join)
        
        attackDices.sort_by!{|x| -x}
        defenseDices.sort_by!{|x| -x}

        numOfFights.times do |n|
            if attackDices[n] > defenseDices[n]
                @defense.changeTroops(:-,1)
            else
                @attack.changeTroops(:-,1)
            end
        end
    end

    def getAttack()
        @attack
    end

    def getDefense()
        @defense
    end
end