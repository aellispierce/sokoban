class Cell
  attr_reader :occupant

  OCCUPANTS = { person: "@", crate: "o", wall: "#", open: " ", storage: ".",
                person_on_storage: "+", crate_on_storage: "*" }

  def initialize(board, occupant)
    @board = board
    @occupant = occupant
  end

  def available?
    occupant == OCCUPANTS[:open] || occupant == OCCUPANTS[:storage]
  end

  def open?
    occupant == OCCUPANTS[:open]
  end

  def crate?
    occupant == OCCUPANTS[:crate]
  end

  def storage?
    occupant == OCCUPANTS[:storage]
  end

  def has_crate?
    crate? || crate_on_storage?
  end

  def crate_on_storage?
    occupant == OCCUPANTS[:crate_on_storage]
  end

  def person?
    occupant == OCCUPANTS[:person]
  end

  def person_on_storage?
    occupant == OCCUPANTS[:person_on_storage]
  end

  def update_occupant(new_occupant)
    self.occupant = OCCUPANTS[new_occupant]
  end

  private

  attr_writer :occupant
end
