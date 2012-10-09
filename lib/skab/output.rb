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
      ['distribution', 'differential', 'summary']
    end

    def self.help
      <<-HELP
The following outputs are available: #{output_names.join(', ')}
\tTry `skab help output [output] to find out more about a given output
      HELP
    end
  end
end
