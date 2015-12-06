require_relative "board"
require_relative "person"
require_relative "cell"

class Game
  attr_reader :board

  def initialize
    @board = Board.new(level: 1)
  end

  def play
    until board.level_completed?
      input = nil
      until valid?(input)
        puts "Use the letters hjkl to move right, up, down or left."
        input = gets.chomp.downcase
      end
      board.person.move(input)
      puts board
    end
  end

  def valid?(input)
    %w[h j k l].include?(input)
  end
end

game = Game.new
puts game.board
game.play
