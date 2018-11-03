module Functional
  def head(n)
    n.to_a[0]
  end
    
  def tail(n)
    n.to_a[1..-1]
  end

  def empty(n)
    return n.empty?
  end
end