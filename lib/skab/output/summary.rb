module Skab
  module Output
    class Summary
      def initialize(out)
        @out = out
      end

      def output(model)
        min = model.percentile(0.05)
        max = model.percentile(0.95)

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
