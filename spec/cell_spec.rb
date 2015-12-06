require "spec_helper"

describe Cell do
  describe "#available?" do
    it "responds true if cell is open or storage" do
      board = Board.new(level: 1)
      cell = Cell.new(board, ".")
      other_cell = Cell.new(board, " ")

      expect(cell.available?).to eq(true)
      expect(other_cell.available?).to eq(true)
    end
  end

  it "answers questions about occupant type" do
    board = Board.new(level: 1)
    cell = Cell.new(board, "o")
    expect(cell.crate?).to eq(true)

    cell = Cell.new(board, " ")
    expect(cell.open?).to eq(true)

    cell = Cell.new(board, ".")
    expect(cell.storage?).to eq(true)

    cell = Cell.new(board, "*")
    expect(cell.crate_on_storage?).to eq(true)

    cell = Cell.new(board, "@")
    expect(cell.person?).to eq(true)

    cell = Cell.new(board, "+")
    expect(cell.person_on_storage?).to eq(true)
  end
end
