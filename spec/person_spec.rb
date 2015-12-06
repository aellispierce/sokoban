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
      board = <<-EOS
      # #
      #@#
      ###
      EOS
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("k")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i - 20)
    end

    it "can move down using j" do
      board = <<-EOS
      ###
      #@#
      # #
      EOS
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("j")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i + 20)
    end

    it "can move left using h" do
      board = <<-EOS
      ###
       @#
      ###
      EOS
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("h")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i - 1)
    end

    it "can move right using l" do
      board = <<-EOS
      #####
      #@ ##
      #####
      EOS
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("l")
      ending_location = person.location

      expect(ending_location).to eq(starting_location.to_i + 1)
    end

    it "cant move through walls" do
      board = <<-EOS
      ###
      #@#
      ###
      EOS
      stub_level(board)
      board = Board.new(level: 1)
      person = board.person
      starting_location = person.location
      person.move("l")
      ending_location = person.location

      expect(ending_location).to eq(starting_location)
    end

    it "can move crate" do
      initial_board = <<-EOS
      # #
      #o#
      #@#
      EOS
      stub_level(initial_board)
      board = Board.new(level: 1)
      person = board.person
      person.move("k")
      final_board = <<-EOS
      #o#
      #@#
      # #
      EOS

      expect("#{board}".split.join(" ")).to eq(final_board.split.join(" "))
    end

    it "can't move crate through wall" do
      initial_board = <<-EOS
      ###
      #o#
      #@#
      EOS
      stub_level(initial_board)
      board = Board.new(level: 1)
      person = board.person
      person.move("k")
      final_board = <<-EOS
      ###
      #o#
      #@#
      EOS

      expect("#{board}".split.join(" ")).to eq(final_board.split.join(" "))
    end

    it "can't move two crates at once" do
      initial_board = <<-EOS
      # #
      #o#
      #o#
      #@#
      EOS
      stub_level(initial_board)
      board = Board.new(level: 1)
      person = board.person
      person.move("k")
      final_board = <<-EOS
      # #
      #o#
      #o#
      #@#
      EOS

      expect("#{board}".split.join(" ")).to eq(final_board.split.join(" "))
    end

    it "can move crate into storage" do
      initial_board = <<-EOS
      #.#
      #o#
      #@#
      EOS
      stub_level(initial_board)
      board = Board.new(level: 1)
      person = board.person
      person.move("k")
      final_board = <<-EOS
      #*#
      #@#
      # #
      EOS

      expect("#{board}".split.join(" ")).to eq(final_board.split.join(" "))
    end

    it "can move from storage to open space" do
      initial_board = <<-EOS
      # #
      #+#
      EOS
      stub_level(initial_board)
      board = Board.new(level: 1)
      person = board.person
      person.move("k")
      final_board = <<-EOS
      #@#
      #.#
      EOS

      expect("#{board}".split.join(" ")).to eq(final_board.split.join(" "))
    end

    it "can push crate from storage to storage" do
      initial_board = <<-EOS
      #####
      #  @#
      #  *#
      #  .#
      #####
      EOS
      stub_level(initial_board)
      board = Board.new(level: 1)
      person = board.person
      person.move("j")
      final_board = <<-EOS
      #####
      #   #
      #  +#
      #  *#
      #####
      EOS

      expect("#{board}".split.join(" ")).to eq(final_board.split.join(" "))
    end
    it "can push crate from storage to open space" do
      initial_board = <<-EOS
      #####
      # *@#
      #####
      EOS
      stub_level(initial_board)
      board = Board.new(level: 1)
      person = board.person
      person.move("h")
      final_board = <<-EOS
      #####
      #o+ #
      #####
      EOS

      expect("#{board}".split.join(" ")).to eq(final_board.split.join(" "))
    end
  end

  def stub_level(board)
    allow(File).to receive(:readlines).and_return(StringIO.new(board))
  end
end
