require 'ruby2d'

class Button
  def initialize(x,y, colorOn, colorOff)
    if self.class == Button
      raise 'Trying to instantiate an abstract class'
    end
    
    @btnOff = Quad.new(
      x1: x,
      y1: y, 
      x2: x+100, 
      y2: y, 
      x3: x+100, 
      y3: y+50, 
      x4: x, 
      y4: y+50,
      z: 1,
      color: colorOff
    )
    @btnOn = Quad.new(
      x1: x,
      y1: y, 
      x2: x+100, 
      y2: y, 
      x3: x+100, 
      y3: y+50, 
      x4: x, 
      y4: y+50,
      z: -1,
      color: colorOn
    )
  end

  def active()
    @btnOff.z = -1
    @btnOn.z = 1
  end

  def desactive()
    @btnOff.z = 1
    @btnOn.z = -1
  end

  def hovered()
    if @btnOn.z == 1
      return true
    end
    return false
  end

  def verifyHover(x,y)
    if @btnOn.contains?(x,y)
      self.active()
    else
      self.desactive()
    end
  end
end

