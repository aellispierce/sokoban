class Board
  def initialize(level:)
    @level = level
  end

  def to_s
    lines = File.readlines("sokoban_levels.txt")
    levels = lines.map { |line| line.chomp.ljust(19) }.join("\n")
    levels = levels.split(/\n {19}\n/)

    levels[@level - 1]
  end
end
