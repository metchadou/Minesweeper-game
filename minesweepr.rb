require "byebug"
require "yaml"
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

  def perform_action(action, pos)
    tile = @board[pos]

    case action
    when "r"
      tile.reveal
    when "f"
      tile.flag
    when "u"
      tile.unflag
    when "s" # When saving, enter any position (e.g. s 0 0)
      save
    end
  end

  def play_turn
    @board.render
    prompt
    input  = nil
    until @board.valid_input?(input)
      input = @board.get_input
    end
    perform_action(@board.get_action(input), @board.get_pos(input))
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

  def save
    print "Saving...\nEnter a file name to save at\n"
    filename = gets.chomp

    File.write(filename, YAML.dump(self))
  end

end

if __FILE__ == $PROGRAM_NAME
  case ARGV.count
  when 0
    MineSweeper.new.run
  when 1
    YAML.load_file(ARGV.shift).run
  end
end