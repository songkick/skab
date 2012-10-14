module Skab
  module Output
    class GnuplotDifferential
      def initialize(out)
        @out = out
      end

      def output(model)
        @out.puts "set encoding utf8"
        @out.puts "set title"
        @out.puts "set key outside"
        @out.puts "set title \"Difference distribution\""

        @out.puts "set style fill transparent solid 0.5 border"

        @out.puts "plot '-' using 1:2 with filledcurve lc rgb 'red' title \"Pr(\316\264)\""
        model.differential.sort.each do |k, v|
          @out.puts " #{k} #{v}"
        end
      end
    end
  end
end
