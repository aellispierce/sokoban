class Board
  attr_reader :person

  def initialize(level:)
    @level = level
    @person = Person.new
  end

  def to_s
    lines = File.readlines("sokoban_levels.txt")
    levels = lines.map { |line| line.chomp.ljust(19) }.join("\n")
    levels = levels.split(/\n {19}\n/)

    levels[@level - 1]
  end

  def person_location
    self.to_s.index("@")
  end
end
