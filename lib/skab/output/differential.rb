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

      private

      def abs(n)
        n >= 0 ? n : -n
      end
    end
  end
end
