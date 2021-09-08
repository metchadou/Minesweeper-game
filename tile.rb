require "byebug"
require_relative "board"

class Tile

  attr_reader :board
  def initialize(board)
    @board = board
    @revealed, @flagged, @bombed = false, false, false
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
    adjacent_positions = [[0,1], [1,0], [0,-1], [-1,0], 
              [1,-1], [-1,1], [1,1], [-1,-1]]

    adjacent_positions.each do |adjacent_position|
      x, y = position
      ngbor_pos = [x + adjacent_position[0], y + adjacent_position[1]]

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
    if flagged?
      "F"
    elsif bombed? && revealed?
      "B"
    elsif revealed?
      neighbors_bomb_count == 0 ? "." : "#{neighbors_bomb_count}"
    else
      "*"
    end
  end

  def inspect
    info = "@bombed: #{@bombed}, @flagged: #{@flagged}, @revealed: #{@revealed}"
    info.inspect
  end

end