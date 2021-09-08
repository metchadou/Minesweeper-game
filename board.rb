require "byebug"
require_relative "tile"

class Board

  def initialize
    @board = Array.new(9) {Array.new(9)}
    fill_board
  end

  def size
    @board.length
  end

  def [](position)
    row, col = position
    @board[row][col]
  end

  def get_input
    gets.chomp
  end

  def get_pos(input)
    input.split(" ").drop(1).map(&:to_i)
  end

  def valid_input?(input)
    input = input.split(" ")

    if input.length == 3 &&
      (input.first == "r" || input.first == "f") &&
      input.drop(1).map(&:to_i).all? {|num| num.between?(0, @board.length-1)}
      return true
    end

    false
  end

  def won?
    @board.each do |row|
      row.each do |tile|
        return false if !tile.bombed? && !tile.revealed?
      end
    end

    true
  end

  def lost?
    @board.each do |row|
      row.each do |tile|
        return true if tile.bombed? && tile.revealed?
      end
    end

    false
  end

  def fill_board
    (0...@board.length).each do |row|
      (0...@board.length).each do |col|
        @board[row][col] = Tile.new(self)
      end
    end

    seed_bombs
  end

  def seed_bombs
    total_bombed_tiles = 0

    until total_bombed_tiles == 10
      row, col = [rand(@board.length), rand(@board.length)]
      tile = @board[row][col]

      if !tile.bombed?
        tile.seed_bomb 
        total_bombed_tiles += 1
      end
    end
  end


end