require "spec_helper"

describe Person do
  describe "#location" do
    it "returns the coordinate location of the person" do
      board = Board.new(level: 1)
      person = board.person

      expect(person.location).to eq(board.to_s.index("@"))
    end
  end

  describe "#move" do
    it "can move up using k" do
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("k")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i + 20)
    end

    it "can move down using j" do
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("j")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i - 20)
    end

    it "can move left using h" do
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("h")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i - 1)
    end

    it "can move right using l" do
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("l")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i + 1)
    end
  end
end
