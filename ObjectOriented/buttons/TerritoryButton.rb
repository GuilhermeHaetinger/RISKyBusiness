$LOAD_PATH << '.'

require './buttons/Button'
require './modules/zorder'
require './modules/constants'
require 'Battle'

class TerritoryButton < Button
  def initialize(game, territory, x, y)
    @image = Gosu::Image.new('../assets/img/player1_troops.png', false)
    super(game.getMain(), Gosu::Image.new('../assets/img/player1_troops.png', false), x, y, ZOrder::SPRITES, 
      method(:callback))
    @font = Gosu::Font.new(40)
    @game = game
    @territory = territory
  end

  def draw() 
    @font.draw_text("#{@territory.getNumOfTroops()}", @territory.getX()+15, @territory.getY()+15, ZOrder::SPRITES, 1.0, 1.0, Gosu::Color::YELLOW)
    super()
  end

  def handleOrganizePhase(id)
    if id == Gosu::MsLeft && @game.playerTurn.getTroopsAvailable() > 0
      @territory.increaseTroops(1)
      @game.playerTurn.decreaseTroops(1)
    elsif id == Gosu::MsRight && @territory.getNumOfTroops() > @territory.getRoundTroops()
      @territory.decreaseTroops(1)
      @game.playerTurn.increaseTroops(1)
    end
  end

  def handleTroopPlacement(id)
    if id == Gosu::MsLeft && @game.playerTurn.getTroopsAvailable() > 0
      @territory.increaseTroops(1)
      @game.playerTurn.decreaseTroops(1)
    elsif id == Gosu::MsRight && @territory.getNumOfTroops() > @territory.getRoundTroops()
      @territory.decreaseTroops(1)
      @game.playerTurn.increaseTroops(1)
    end
  end

  def handleAttack(id)
    preSelect = @game.getPreSelectedTerritory()
    if preSelect == nil
      if @territory.getNumOfTroops() > 1 and @territory.areThereEnemiesAdjacent()
        @game.setPreSelectedTerritory(@territory)
      end
    elsif preSelect == @territory
      @game.setPreSelectedTerritory(nil)
    elsif preSelect.getAdjacentTerritories().include? @territory and @game.playerTurn().getId() != @territory.getPlayerId()
      battle = Battle.new(@game, preSelect, @territory)
      battle.fight()
      if @territory.getNumOfTroops() == 0
        if @territory.getPlayerId() == 0
          self.changeMainImage(Constants::PLAYER2_IMAGE)
        else
          self.changeMainImage(Constants::PLAYER1_IMAGE)
        end
        @territory.setPlayer(preSelect.getPlayerId())
        @game.setState(Constants::VICTORY_MANAGEMENT)
        @game.setConquest(battle)
      end
      @game.setPreSelectedTerritory(nil)
    end
  end
    
  def handleVictoryManagement(id)
    if @territory == @game.getConquest().getDefense()
      if id == Gosu::MsLeft && @game.getConquest().getDefense().getNumOfTroops() < 3 and @game.getConquest().getAttack().getNumOfTroops() > 1
        @game.getConquest().getDefense().increaseTroops(1)
        @game.getConquest().getAttack().decreaseTroops(1)
      elsif id == Gosu::MsRight && @game.getConquest().getDefense().getNumOfTroops() > 0
        @game.getConquest().getDefense().decreaseTroops(1)
        @game.getConquest().getAttack().increaseTroops(1)
      end
    end
  end
  
  def handleManagement(id)
    preSelect = @game.getPreSelectedTerritory()
    if preSelect == nil
      if @territory.getNumOfTroops() > 1 and @territory.areThereAlliesAdjacent() and @territory.getRemanagedTroops() < @territory.getRoundTroops()
        @game.setPreSelectedTerritory(@territory)
      end
    elsif preSelect == @territory
      @game.setPreSelectedTerritory(nil)
    elsif preSelect.getAdjacentTerritories().include? @territory and @game.playerTurn().getId() == @territory.getPlayerId()
      if id == Gosu::MsLeft and @game.getPreSelectedTerritory().getNumOfTroops() > 1
        @territory.increaseTroops(1)
        @game.getPreSelectedTerritory().decreaseTroops(1)
        @game.getPreSelectedTerritory().increaseRemanagedTroops()
        @game.setPreSelectedTerritory(nil)
      end
    end
  end

  def setAsAttackable()
    self.setActiveImage(Constants::ATTACK_IMAGE)
  end

  def setAsMovable()
    self.setActiveImage(Constants::MOVE_IMAGE)
  end

  def callback (id)
    if @game.getState() == Constants::ORGANIZE_PHASE
      self.handleOrganizePhase(id)
    elsif @game.getState() == Constants::TROOP_PLACEMENT
      self.handleTroopPlacement(id)
    elsif @game.getState() == Constants::ATTACK
      self.handleAttack(id)
    elsif @game.getState() == Constants::VICTORY_MANAGEMENT
      self.handleVictoryManagement(id)
    elsif @game.getState() == Constants::MANAGEMENT
      self.handleManagement(id)
    end
  end

end