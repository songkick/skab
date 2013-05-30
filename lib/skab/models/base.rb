module Skab
  module Models
    class Base

      private

      def factorial(n)
        @_factorials ||= {
          0 => 1,
          1 => 1
        }

        raise "Illegal factorial, expecting n > 0" if n < 0

        last = @_factorials.keys.last
        (last..n).each do |i|
          @_factorials[i] = i * @_factorials[i - 1]
        end

        return @_factorials[n]
      end

    end
  end
end
