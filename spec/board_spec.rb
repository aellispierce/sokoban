require "spec_helper"

describe Board do
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
end
