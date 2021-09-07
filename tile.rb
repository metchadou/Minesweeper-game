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

  def position
    (0...@board.length).each do |row|
      (0...@board.length).each do |col|
        pos = [row, col]
        return pos if @board[pos] == self
      end
    end
  end

  def neighbors
    ngbors = []
    deltas = [[0,1], [1,0] [0,-1], [-1,0], 
              [1,-1], [-1,1], [1,1], [-1,-1]]

    deltas.each do |d|
      x, y = position
      ngbor_pos = [x + delta[0], y + delta[1]]

      ngbors << @board[ngbor_pos] if !ngbor_pos.nil?
    end

    ngbors
  end

  def neighbors_bomb_count
    neighbors.count {|ngbor| ngbor.bombed?}
  end

  
  
end