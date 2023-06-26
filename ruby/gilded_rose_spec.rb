require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    before(:all) { `./test.sh` }

    it "has no regression" do
      golden_master = "spec/golden_master.txt"
      actual = "spec/current_output.txt"

      expect(IO.read(actual)).to eq IO.read(golden_master)
    end

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

end
