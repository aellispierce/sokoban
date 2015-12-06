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
    new_location = person.location + index
    if available?(new_location)
      move_person(new_location)
    elsif crate?(new_location) && available?(new_location + index)
      move_person(new_location)
      move_crate(index)
    end
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

  def storage?(cell)
    cells[cell] == STORAGE || cells[cell] == CRATE_ON_STORAGE
  end

  def move_person(new_location)
    update_current_location
    move_to_new_location(new_location)
  end

  def move_crate(index)
    cell = person.location + index
    if cells[cell] == OPEN
      cells[cell] = CRATE
    else
      cells[cell] = CRATE_ON_STORAGE
    end
  end

  def update_current_location
    if cells[person.location] == PERSON_ON_STORAGE
      cells[person.location] = STORAGE
    else
      cells[person.location] = OPEN
    end
  end

  def move_to_new_location(new_location)
    if storage?(new_location)
      cells[new_location] = PERSON_ON_STORAGE
    else
      cells[new_location] = PERSON
    end
  end
end
