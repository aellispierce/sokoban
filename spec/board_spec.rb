require "spec_helper"

describe Board do
  describe "#initialize" do
    it "takes a level parameter" do
      expect { Board.new }.to raise_error(ArgumentError)
    end

    it "creates a new person" do
      board = Board.new(level: 1)

      expect(board.person).to be_kind_of(Person)
    end
  end

  describe "#to_s" do
    it "displays the board as a string" do
      board = Board.new(level: 4)

      expect("#{board}".split.join(" ")).to eq(<<-EOS.split.join(" "))
              ########
              #  ....#
        ############  ....#
        #    #  o o   ....#
        # ooo#o  o #  ....#
        #  o     o #  ....#
        # oo #o o o########
        #  o #     #
        ## #########
        #    #    ##
        #     o   ##
        #  oo#oo  @#
        #    #    ##
        ###########
      EOS
    end
  end

  describe "#person_location" do
    it "returns the coordinate location of the person" do
      board = Board.new(level: 1)

      expect(board.person_location).to eq(board.to_s.index("@"))
    end
  end
end
