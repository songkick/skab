module Skab
  module Output
    class GnuplotDistribution
      def initialize(out)
        @out = out
      end

      def output(model)
        @out.puts "set title"
        @out.puts "set key outside"
        @out.puts "set title \"Probability density distribution\""

        @out.puts "set style fill transparent solid 0.5 border"

        interval = [model.distribution.first[0], model.distribution.last[0]]
        @out.puts "plot '-' using 1:2 with filledcurve lc rgb 'red' title 'Group A', \\"
        @out.puts "\t'' using 1:2 with filledcurve lc rgb 'blue' title 'Group B'"
        model.distribution.each do |d|
          @out.puts " #{d[0]} #{d[1]}"
        end
        @out.puts "e"
        model.distribution.each do |d|
          @out.puts " #{d[0]} #{d[2]}"
        end
        @out.puts "e"
      end
    end
  end
end
