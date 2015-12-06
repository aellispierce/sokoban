class Board
  attr_reader :person, :level

  PERSON  = "@"
  CRATE   = "o"
  WALL    = "#"
  OPEN    = " "
  STORAGE = "."
  PERSON_ON_STORAGE = "+"
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

    @cells = levels[level - 1]
  end

  def to_s
    cells
  end

  def update(index)
    person = find_person
    new_location = person + index
    if available?(new_location)
      move_person(person, index)
    elsif has_crate?(new_location) && available?(new_location + index)
      move_person(person, index)
      move_crate(index)
    end
  end

  def find_person
    cells.index(PERSON) || cells.index(PERSON_ON_STORAGE)
  end

  def level_completed?
    !cells.include?("o")
  end

  private

  attr_reader :cells

  def available?(cell)
    cells[cell] == OPEN || cells[cell] == STORAGE
  end

  def has_crate?(cell)
    cells[cell] == CRATE || cells[cell] == CRATE_ON_STORAGE
  end

  def move_person(person, index)
    update_previous_location(person)
    move_to_new_location(person, index)
  end

  def move_crate(index)
    if cells[find_person + index] == OPEN
      cells[find_person + index] = CRATE
    else
      cells[find_person + index] = CRATE_ON_STORAGE
    end
  end

  def update_previous_location(person)
    if cells[person] == PERSON_ON_STORAGE
      cells[person] = STORAGE
    else
      cells[person] = OPEN
    end
  end

  def move_to_new_location(person, index)
    if cells[person + index] == STORAGE || cells[person + index] == CRATE_ON_STORAGE
      cells[person + index] = PERSON_ON_STORAGE
    else
      cells[person + index] = PERSON
    end
  end
end
