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
    new_location = person_location + index
    if available?(new_location)
      move_person(index)
    elsif crate?(new_location) && available?(new_location + index)
      move_person(index)
      move_crate(index)
    end
  end

  def person_location
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

  def crate?(cell)
    cells[cell] == CRATE || cells[cell] == CRATE_ON_STORAGE
  end

  def move_person(index)
    current_location = person_location
    update_current_location
    move_to_new_location(current_location, index)
  end

  def move_crate(index)
    if cells[person_location + index] == OPEN
      cells[person_location + index] = CRATE
    else
      cells[person_location + index] = CRATE_ON_STORAGE
    end
  end

  def update_current_location
    if cells[person_location] == PERSON_ON_STORAGE
      cells[person_location] = STORAGE
    else
      cells[person_location] = OPEN
    end
  end

  def storage?(cell)
    cells[cell] == STORAGE || cells[cell] == CRATE_ON_STORAGE
  end

  def move_to_new_location(current_location, index)
    cell = current_location + index
    if storage?(cell)
      cells[cell] = PERSON_ON_STORAGE
    else
      cells[cell] = PERSON
    end
  end
end
