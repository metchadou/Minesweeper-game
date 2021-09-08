require "byebug"
require_relative "board"

class MineSweeper
  
  def initialize
    @board = Board.new
  end

  def over?
    @board.won? || @board.lost?
  end

  def prompt
    puts "Enter an action ('r' to reveal and 'f' to flag) and a position (e.g. 'r 2 4')"
    print "> "
  end

  def play_turn
    @board.render
    prompt
    input  = nil
    until @board.valid_input?(input)
      input = @board.get_input      
    end
    @board.act(@board.get_action(input), @board.get_pos(input))
  end

  def congrat
    @board.render
    puts "Congratulations you won !"
  end

  def encourage
    @board.render
    puts "Sorry you lost"
  end

  def run
    play_turn until over?
    @board.won? ? congrat : encourage
  end

end

if __FILE__ == $PROGRAM_NAME
  MineSweeper.new.run
end