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

  describe "#level_completed" do
    it "responds true if level has no crates" do
      board = <<-EOS
      ###
      #@#
      ###
      EOS
      stub_level(board)
      board = Board.new(level: 1)
      expect(board.level_completed?).to eq(true)
    end

    it "responds false if level has crates" do
      board = <<-EOS
      ###
      #o#
      ###
      EOS
      stub_level(board)
      board = Board.new(level: 1)
      expect(board.level_completed?).to eq(false)
    end
  end

  def stub_level(board)
    allow(File).to receive(:readlines).and_return(StringIO.new(board))
  end
end
