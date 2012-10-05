require 'statisfish/output/distribution'
require 'statisfish/output/differential'

module Statisfish
  module Output
    def self.from_name(name)
      case name
        when 'differential'
          Differential
        when 'distribution'
          Distribution
      end
    end
  end
end
