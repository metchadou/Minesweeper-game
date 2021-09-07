class Tile

  def initialize(board)
    @board = board
    @revealed = false
    @flagged = false
    @bombed = false
  end

  def revealed?
    @revealed
  end

  def flagged?
    @flagged
  end

  def bombed?
    @bombed
  end

  def reveal
    @revealed = true
  end

  def flag
    @flagged = true
  end

  def seed_bomb
    @bombed = true
  end

  def neighbors
    ngbors = []
    deltas = [[0,1], ]

  end
  
end