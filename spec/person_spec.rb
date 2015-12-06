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
      board = %q[
      # #
      #@#
      ###].strip
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("k")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i - 20)
    end

    it "can move down using j" do
      board = %q[
      ###
      #@#
      # #].strip
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("j")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i + 20)
    end

    it "can move left using h" do
      board = %q[
      ###
       @#
      ###].strip
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("h")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i - 1)
    end

    it "can move right using l" do
      board = %q[
      #####
      #@ ##
      #####].strip
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("l")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i + 1)
    end

    it "cant move through walls" do
      board = %q[
      ###
      #@#
      ###].strip
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("l")
      ending_location = person.location

      expect(ending_location).to eq(starting_location)
    end
  end

  def stub_level(board)
    allow(File).to receive(:readlines).and_return(StringIO.new(board))
  end
end
