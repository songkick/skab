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

        @out.puts "The difference is located between #{min} and #{max} (90% accuracy)"
      end
    end
  end
end
