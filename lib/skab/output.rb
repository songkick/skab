module Skab
  require ROOT + '/skab/output/distribution'
  require ROOT + '/skab/output/differential'
  require ROOT + '/skab/output/summary'

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
