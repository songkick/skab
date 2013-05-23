#!/usr/bin/env ruby

require 'csv'
require 'skab'
require 'stringio'

# This is a demo of using the skab gem in your own application.
args = [100, 10, 120, 5]

binomial_model = Skab::Models.from_name('binomial').new(args)

buffer = StringIO.new
distribution_output = Skab::Output.from_name('distribution').new(buffer)
distribution_output.output(binomial_model)

buffer.rewind

csv = CSV.new(buffer)
csv.each do |line|
  vals = line.map {|str| str.to_f}
  improvement = vals[0]
  pA = vals[1]
  pB = vals[2]
  # Do stuff with the values read in.  
end

buffer.close
