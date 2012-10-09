module Skab
  module Output
    class Distribution
      def initialize(out)
        @out = out
      end

      def output(model)
        model.distribution.each do |d|
          @out.puts "#{d.join(',')}"
        end
      end

      def self.help
        <<-HELP
Usage: skab distribution [model] [parameters]
\tOutputs the discrete probability distribution for both A and B, as
\treturned by the specified model. The output is a three columns CSV
\tfile, where the first column is the probable mean and the second and
\tthird column the corresponding discrete probability for A and B.
        HELP
      end
    end
  end
end
