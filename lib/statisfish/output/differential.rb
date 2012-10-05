module Statisfish
  module Output
    class Differential
      def initialize(out)
        @out = out
      end

      def output(model)
        Hash[model.differential.sort].each do |k, v|
          @out.puts "#{k},#{v}"
        end
      end
    end
  end
end
