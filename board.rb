class Board
  attr_reader :person, :level

  PERSON  = "@"
  CRATE   = "o"
  WALL    = "#"
  OPEN    = " "
  STORAGE = "."
  MAN_ON_STORAGE    = "+"
  CRATE_ON_STORAGE  = "*"

  def initialize(level:)
    @level = level
    @person = Person.new(self)
    make_board
  end

  def make_board
    lines = File.readlines("sokoban_levels.txt")
    levels = lines.map { |line| line.chomp.ljust(19) }.join("\n")
    levels = levels.split(/\n {19}\n/)

    @cells = levels[level - 1].chars
  end

  def to_s
    cells.join
  end

  def update(index)
    person = find_person
    new_location = person + index
    if available?(new_location)
      cells[person] = OPEN
      cells[new_location] = PERSON
    end
  end

  def find_person
    cells.index(PERSON)
  end

  private

  attr_reader :cells

  def available?(cell)
    cells[cell] == OPEN
  end
end
