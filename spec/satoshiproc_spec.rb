require_relative '../lib/satoshiproc-unit'

describe SatoshiProc do

  it "creates a Bignum representing value in satoshiproc units" do
    expect(SatoshiProc.new(1.00).to_i).to eq(100000000)
  end

  it "takes care of the sign before the value" do
    expect(SatoshiProc.new(-1.00).to_i).to eq(-100000000)
  end

  it "converts satoshiproc unit back to some more common denomination" do
    expect(SatoshiProc.new(1.00).to_proc).to eq(1)
    expect(SatoshiProc.new(1.08763).to_proc).to eq(1.08763)
    expect(SatoshiProc.new(1.08763).to_mproc).to eq(1087.63)
    expect(SatoshiProc.new(-1.08763).to_mproc).to eq(-1087.63)
    expect(SatoshiProc.new(0.00000001).to_i).to eq(1)
    expect(SatoshiProc.new(0.00000001).to_mproc).to eq(0.00001)
  end
   
  it "converts from various source denominations" do
    expect(SatoshiProc.new(1, unit: 'mproc').to_proc).to      eq(0.001)
    expect(SatoshiProc.new(1, unit: 'mproc').to_unit).to     eq(1)
    expect(SatoshiProc.new(10000000, unit: 'mproc').to_unit).to eq(10000000)
    satoshiproc = SatoshiProc.new(10000000, unit: 'mproc')
    satoshiproc.satoshiproc_value = 1
    expect(satoshiproc.to_unit).to eq(0.00001)
    expect(SatoshiProc.new(100, unit: 'mproc').to_i).to eq(10000000)
  end

  it "treats nil in value as 0" do
    expect(SatoshiProc.new < 1).to be_truthy
    expect(SatoshiProc.new > 1).to be_falsy
    expect(SatoshiProc.new == 0).to be_truthy
  end

  it "converts negative values correctly" do
    expect(SatoshiProc.new(-1.00, unit: :mproc).to_proc).to eq(-0.001)
  end

  it "converts zero values correctly" do
    expect(SatoshiProc.new(0, unit: :mproc).to_unit).to eq(0)
  end

  it "converts nil values correctly" do
    s = SatoshiProc.new(nil, unit: :mproc)
    expect(s.value).to eq(0)
    s.value = nil
    expect(s.to_unit).to eq(0)
  end

  it "displays one SatoshiProc in human form, not math form" do
    one_satoshiproc = SatoshiProc.new(1, from_unit: :satoshiproc, to_unit: :proc)
    expect(one_satoshiproc.to_unit(as: :string)).not_to eq('1.0e-08')
    expect(one_satoshiproc.to_unit(as: :string)).to eq('0.00000001')
  end

  it "displays zero SatoshiProc in human form, not math form" do
    zero_satoshiproc = SatoshiProc.new(0, from_unit: :satoshiproc, to_unit: :proc)
    expect(zero_satoshiproc.to_unit(as: :string)).to eq('0.0')
  end

  it "raises exception if decimal part contains more digits than allowed by from_value" do
    expect( -> { SatoshiProc.new(0.001000888888888888888, from_unit: :proc).to_unit }).to raise_exception(SatoshiProc::TooManyDigitsAfterDecimalPoint)
    expect( -> { SatoshiProc.new("0.001000999999999999999", from_unit: :proc).to_unit }).to raise_exception(SatoshiProc::TooManyDigitsAfterDecimalPoint)
    expect( -> { SatoshiProc.new(0.001000999, from_unit: :proc).to_unit }).to raise_exception(SatoshiProc::TooManyDigitsAfterDecimalPoint)
    expect( -> { SatoshiProc.new(0.00100099, from_unit: :proc).to_unit }).not_to raise_exception
    expect( -> { SatoshiProc.new(0.123456789, from_unit: :proc) }).to raise_exception(SatoshiProc::TooManyDigitsAfterDecimalPoint)
    expect( -> { SatoshiProc.new(0.12345678, from_unit: :proc).to_unit }).not_to raise_exception
    expect( -> { SatoshiProc.new(nil, from_unit: :proc).to_unit }).not_to raise_exception
  end

  it "disallows to create values more than 21mil PROC" do
    expect( -> { SatoshiProc.new(21_000_001) }).to raise_exception(SatoshiProc::TooLarge)
    expect( -> { SatoshiProc.new(21_000_000) }).not_to raise_exception
  end

  it "returns satoshiproc for +,- and * methods if both operands are SatoshiProc" do
    s1 = SatoshiProc.new(0.001, from_unit: :proc)
    s2 = SatoshiProc.new(0.002, from_unit: :proc)
    expect(s1+s2).to be_kind_of(SatoshiProc)
    expect((s1+s2).to_unit).to eq(0.003)
    expect(s2-s1).to be_kind_of(SatoshiProc)
    expect((s2-s1).to_unit).to eq(0.001)
    expect(s2*s1).to be_kind_of(SatoshiProc)
    expect((s2*s1).to_unit).to eq(200)
  end

end
