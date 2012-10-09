module Skab
  module Output
    class Summary
      def initialize(out)
        @out = out
      end

      def output(model)
        sum = 0.0
        min = 0
        max = 0
        Hash[model.differential.sort].each do |k, v|
          sum += v
          if min == 0 || sum <= 0.05
            min = k
          end
          if max == 0 && sum >= 0.95
            max = k
          end
        end

        @out.puts "The difference is located between #{min} and #{max} (90% confidence)"
      end

      def self.help
        <<-HELP
Usage: skab summary [model] [parameters]
\tOutputs a summary of the whole statistical analysis conducted on A and
\tB, using the specified model.
        HELP
      end
    end
  end
end
