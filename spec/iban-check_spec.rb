require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "IbanCheck" do
  it "should create proper checksum from valid IBAN number" do
    iban = Iban::IbanCheck.new :iban => "PL27 1140 2004 0000 3002 0135 5387"
    iban.checksum.should == "27"
    iban.iban?.should == true

    iban = Iban::IbanCheck.new :iban => "HU42 1177 3016 1111 1018 0000 0000"
    iban.checksum.should == "42"
    iban.iban?.should == true
  end

  it "should create proper checksum from invalid IBAN number" do
    iban = Iban::IbanCheck.new :iban => "PL27 1140 2004 0010 3002 0135 5387"
    iban.checksum.should == "10"
    iban.iban?.should == false
  end

  it "should raise error -- no country" do
    lambda {Iban::IbanCheck.new(:iban => "27 1140 2004 0010 3002 0135 5387")}.should raise_error(Iban::MissingCountryException)
  end

  it "should recognize country" do
    iban = Iban::IbanCheck.new :iban => "PL27 1140 2004 0010 3002 0135 5387"
    iban.country.should == "PL"
  end

  it "should create proper checksum for branch" do
    iban = Iban::IbanCheck.new :iban => "PL27 1140 2004 0010 3002 0135 5387"
    iban.check_branch.should == 4

    iban = Iban::IbanCheck.new :iban => "PL27 1145 2024 0010 3002 0135 5387"
    iban.check_branch.should_not == 4
  end

  it "should answer true for proper branch" do
    iban = Iban::IbanCheck.new :iban => "PL27 1160 2202 0010 3002 0135 5387"
    iban.branch?.should == true
  end

  it "should return iban with recalculated checksum" do
    iban = Iban::IbanCheck.new :iban      => "PL00 1140 2004 0000 3002 0135 5387"
    iban.checksum.should == "27"

    iban.recalculate_checksum.should ==   "27114020040000300201355387"
  end

end
