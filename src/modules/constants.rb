module Constants
  WINDOW_HEIGHT = 720
  WINDOW_WIDTH = 1280
  EMPTY = 0
  ORGANIZE_PHASE, TROOP_PLACEMENT, ATTACK, VICTORY_MANAGEMENT, MANAGEMENT = *0..4
  PLAYER1_IMAGE = Gosu::Image.new('../assets/img/player1_troops.png', false)
  PLAYER2_IMAGE = Gosu::Image.new('../assets/img/player2_troops.png', false)
  ATTACK_IMAGE = Gosu::Image.new('../assets/img/attack_territory.png', false)
  MOVE_IMAGE = Gosu::Image.new('../assets/img/move_territory.png', false)
end