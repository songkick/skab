module Skab
  require ROOT + '/skab/output/distribution'
  require ROOT + '/skab/output/differential'
  require ROOT + '/skab/output/summary'
  require ROOT + '/skab/output/gnuplot_distribution'

  module Output
    def self.from_name(name)
      case name
        when 'differential'
          Differential
        when 'distribution'
          Distribution
        when 'summary'
          Summary
        when 'gnuplot_distribution'
          GnuplotDistribution
      end
    end

    def self.output_names
      ['distribution', 'differential', 'summary', 'gnuplot_distribution']
    end

    def self.help
      <<-HELP
The following outputs are available: #{output_names.join(', ')}
\tTry `skab help output [output] to find out more about a given output
      HELP
    end
  end
end
