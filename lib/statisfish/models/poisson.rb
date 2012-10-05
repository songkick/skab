module Statisfish
  module Models
    class Poisson

      def initialize(args)
        @a = args.shift.to_i
        @b = args.shift.to_i
      end

      def run
        a = @a
        b = @b
        limit = [a, b].max * 2
        @distribution = []
        (0..limit).each do |n|
          @distribution[n] = []
          @distribution[n][0] = normal_approximation(n, a)
          @distribution[n][1] = normal_approximation(n, b)
        end
        @differential = Hash.new(0)
        (0..limit).each do |a|
          (0..limit).each do |b|
            @differential[b - a] += @distribution[b][1] * @distribution[a][0]
          end
        end
      end

      def distribution
        run unless @distribution
        @distribution
      end

      def differential
        run unless @differential
        @differential
      end

      def self.help
        <<-USAGE
statisfish [output] poisson [a] [b]
\tWhere: [a] and [b] are integers
\tPlots the poisson distribution for [a] and [b]
        USAGE
      end
      
      private

      def normal_approximation(k, delta)
        (1 / (Math.sqrt(delta) * Math.sqrt(2 * Math::PI))) * Math.exp(-0.5 * (((k - delta) / Math.sqrt(delta))**2))
      end

      def poisson(k, delta)
        ((delta ** k) * Math.exp(-delta)) / factorial(k)
      end

      def factorial(n)
        f = 1
        (1..n).each do |i|
          f *= i
        end
        f
      end

    end
  end
end
