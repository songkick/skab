require 'statisfish/output/distribution'
require 'statisfish/output/differential'
require 'statisfish/output/summary'

module Statisfish
  module Output
    def self.from_name(name)
      case name
        when 'differential'
          Differential
        when 'distribution'
          Distribution
        when 'summary'
          Summary
      end
    end

    def self.output_names
      ['distribution', 'differential']
    end
  end
end
