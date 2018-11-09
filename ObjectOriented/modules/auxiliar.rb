$LOAD_PATH << '.'
require 'gosu'

module Auxiliar
  def isMouseClick(id)
    (id == Gosu::MsLeft || id == Gosu::MsRight) ? true : false
  end
end