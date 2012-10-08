module Statisfish
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
    end
  end
end
