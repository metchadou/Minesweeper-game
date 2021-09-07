require_relative "tile"

class Board

  def self.grid
    grid = Array.new(9) {Array.new(9, Tile.new)}
    Board.seed_bombs(grid)
  end

  def self.seed_bombs(grid)
    total_bombed_tiles = 0

    until total_bombed_tiles == 10
      row, col = [rand(grid.length), rand(grid.length)]
      tile = grid[row][col]

      if !tiles.include?(tiles)
        tile.seed_bomb 
        total_bombed_tiles += 1
      end
    end
  end

  def initialize
    @grid = 
  end
end