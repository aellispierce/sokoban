class Board
  attr_reader :person, :level

  def initialize(level:)
    @level = level
    @person = Person.new(self)
    create_board
  end

  def create_board
    lines = File.readlines("sokoban_levels.txt")
    levels = lines.map { |line| line.chomp.ljust(19) }.join("\n")
    levels = levels.split(/\n {19}\n/)

    @cells = levels[level - 1].chars.map { |char| Cell.new(self, char) }
  end

  def to_s
    cells.map(&:occupant).join
  end

  def cell_at(index)
    cells[index]
  end

  def update(index)
    new_location = cell_at(person.location + index)
    new_crate_location = cell_at(person.location + (index * 2))
    if new_location.available?
      move_person(new_location)
    elsif new_location.has_crate? && new_crate_location.available?
      move_person(new_location)
      move_crate(index)
    end
  end

  def level_completed?
    cells.none?(&:crate?)
  end

  private

  attr_reader :cells

  def move_person(new_location)
    update_current_location
    move_to_new_location(new_location)
  end

  def move_crate(index)
    cell = cell_at(person.location + index)
    if cell.open?
      cell.update_occupant(:crate)
    else
      cell.update_occupant(:crate_on_storage)
    end
  end

  def update_current_location
    cell = cell_at(person.location)
    if cell.person_on_storage?
      cell.update_occupant(:storage)
    else
      cell.update_occupant(:open)
    end
  end

  def move_to_new_location(new_location)
    if new_location.storage? || new_location.crate_on_storage?
      new_location.update_occupant(:person_on_storage)
    else
      new_location.update_occupant(:person)
    end
  end
end
