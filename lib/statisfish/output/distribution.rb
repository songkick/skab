module Statisfish
  module Output
    class Distribution
      def initialize(out)
        @out = out
      end

      def output(model)
        model.distribution.each_with_index do |d, i|
          @out.puts "#{i},#{d.join(',')}"
        end
      end
    end
  end
end
