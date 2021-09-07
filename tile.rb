require_relative "board"

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

    if !neighbors_have_bomb?
      neighbors.each {|ngbor| ngbor.reveal}
    end
  end

  def flag
    @flagged = true unless revealed?
  end

  def seed_bomb
    @bombed = true
  end

  def position
    (0...@board.size).each do |row|
      (0...@board.size).each do |col|
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

  def neighbors_have_bomb?
    neighbors_bomb_count == 0 ? false : true
  end

  def to_s
    case self
    when flagged?
      "F"
    when bombed? && revealed?
      "B"
    when revealed
      neighbors_bomb_count == 0 ? "." : "#{neighbors_bomb_count}"
    else
      "*"
    end
  end

end