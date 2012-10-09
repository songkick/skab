require 'skab/output/distribution'
require 'skab/output/differential'
require 'skab/output/summary'

module Skab
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
