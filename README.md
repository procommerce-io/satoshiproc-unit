Satoshi Unit
================
This tiny gem allows you to make easy conversions from one Proc denomination into another.
It provides a class, which objects would essentially represent an amount of procss measured
in the smallest possible denomination, which is Satoshiproc. You can then call methods on these objects
to convert it various other denominations.

### Installation

    gem install satoshiproc-unit

### Usage

Here's how it might look:

    s = SatoshiProc.new(1) # By default, it accepts amounts in PROC denomination
    s.to_i             # => 100000000 (in Satoshiprocs)
    s.to_mbtc          # => 1000.0
    s.to_btc           # => 1.0
    
When creating a SatoshiProc object, you can also specify which unit is being used to pass the amount,
for example:

    s = Satoshi.new(1, from_unit: :mproc)
    
    s.to_i    # => 100000
    s.to_mproc # => 1.0
    s.to_proc  # => 0.001
    
There's also a special method which is called `#to_unit`, it always converts to the denomination
specified in the `:to_unit` option in the constructor. It becomes really handy when you want to
specify your preferred denomination used througout the program in just one place
(to be able to change it later):

    DENOMINATION = :mproc
    s = SatoshiProc.new(1, from_unit: DENOMINATION, to_unit: DENOMINATION)
    s.to_unit # => 1.0 (in mBTC)
    
This can be shortened to just the `:unit` option:

    s = SatoshiProc.new(1, unit: DENOMINATION)
    
But, of course, if you want your "from" denomination and "to" denomination to be different, then
you'd have to pass them both manually:

    s = SatoshiProc.new(1, from_unit: :mproc, to_unit: :proc)
    s.to_unit # => 0.001



###Comparing satoshiprocs

SatoshiProc objects come with methods and coercions for comparing itself with both other Satoshi objects and also numeric values:

    s1 = SatoshiProc.new(1)
    s2 = SatoshiProc.new(2)
    
    s1 > s2  # => false
    s1 < s2  # => true
    s1 == s2 # => false
    
    s1 > 1  # => true
    1  > s2 # => false


### Unit tests


Run `rspec spec`. Pull requests with more unit tests are welcome.
