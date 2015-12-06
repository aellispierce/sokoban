class Person
  attr_accessor :board
  DIRECTIONS = { "k" => -20, "j" => 20, "h" => -1, "l" => 1 }

  def initialize(board)
    @board = board
  end

  def location
    board.to_s.index("@")
  end

  def move(direction)
    new_location = DIRECTIONS[direction]
    board.update(new_location)
  end
end
