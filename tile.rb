require "byebug"
require "colorize"
require_relative "board"

class Tile

  attr_reader :board
  def initialize(board, position)
    @board = board
    @revealed, @flagged, @bombed = false, false, false
    @position = position
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
    if !revealed? && !flagged?
      @revealed = true

      if !neighbors_have_bomb?
        neighbors.each {|ngbor| ngbor.reveal}
      end
    end
  end

  def flag
    @flagged = true unless revealed? || flagged?
  end

  def unflag
    @flagged = false if flagged?
  end

  def seed_bomb
    @bombed = true
  end

  def neighbors
    ngbors = []
    adjacent_positions = [[0,1], [1,0], [0,-1], [-1,0], 
              [1,-1], [-1,1], [1,1], [-1,-1]]

    adjacent_positions.each do |adjacent_position|
      x, y = @position
      ngbor_pos = [x + adjacent_position[0], y + adjacent_position[1]]
      ngbors << @board[ngbor_pos] if @board.in_board?(ngbor_pos)
    end

    ngbors
  end

  def neighbors_bomb_count
    neighbors.count {|ngbor| ngbor.bombed?}
  end

  def colorized_neighbors_bomb_count
    count = neighbors_bomb_count

    case count
    when 1
      "#{count}".colorize(:light_blue)
    when 2
      "#{count}".colorize(:light_green)
    else
      "#{count}".colorize(:light_red)
    end
  end

  def neighbors_have_bomb?
    neighbors_bomb_count == 0 ? false : true
  end

  def to_s
    if flagged?
      "F".colorize(:light_blue).on_light_yellow
    elsif bombed? && revealed?
      "B".colorize(:black).on_light_red
    elsif revealed?
      neighbors_bomb_count == 0 ? "." : colorized_neighbors_bomb_count
    else
      "*".colorize(:light_white)
    end
  end

  def inspect
    "@position: #{@position}, @bombed: #{@bombed}, @flagged: #{@flagged}, @revealed: #{@revealed}".inspect
  end

end