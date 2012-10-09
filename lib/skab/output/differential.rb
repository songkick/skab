module Skab
  module Output
    class Differential
      def initialize(out)
        @out = out
      end

      def output(model)
        data = model.differential
        
        range = 0
        data.each do |k, v|
          if v != 0 && abs(k) > range
            range = abs(k)
          end
        end

        range += range / 10

        Hash[data.sort].each do |k, v|
          if abs(k) <= range
            @out.puts "#{k},#{v}"
          end
        end
      end

      def self.help
        <<-HELP
Usage: skab differential [model] [parameters]
\tOutputs the discrete probability distribution for (B - A) as returned by the
\tspecified model. The output is a two columns CSV file, where the first
\tcolumn is the absolute value of (B - A) and the second column the
\tcorresponding discrete probability
        HELP
      end

      private

      def abs(n)
        n >= 0 ? n : -n
      end
    end
  end
end
