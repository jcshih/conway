module Rules
  def stays_alive?(neighbors)
    neighbors.length.between?(2,3)
  end

  def comes_alive?(neighbors)
    neighbors.length == 3
  end
end