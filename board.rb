require "byebug"
require_relative "tile"

class Board

  def self.grid
    grid = Array.new(9) {Array.new(9)}

    (0...grid.length).each do |row|
      (0...grid.length).each do |col|
        grid[row][col] = Tile.new(self)
      end
    end

    Board.seed_bombs(grid)

    grid
  end

  def self.seed_bombs(grid)
    total_bombed_tiles = 0

    until total_bombed_tiles == 10
      row, col = [rand(grid.length), rand(grid.length)]
      tile = grid[row][col]

      if !tile.bombed?
        tile.seed_bomb 
        total_bombed_tiles += 1
      end
    end
  end

  def initialize
    @grid = Board.grid
  end

  def size
    @grid.length
  end


end