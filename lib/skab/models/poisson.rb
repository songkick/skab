module Skab
  module Models
    class Poisson

      def initialize(args)
        @a = args.shift.to_i
        @b = args.shift.to_i
      end

      def distribution
        return @distribution if @distribution
        @distribution = []
        (0..limit).each do |n|
          @distribution[n] = []
          @distribution[n][0] = n
          @distribution[n][1] = normal_approximation(n, a)
          @distribution[n][2] = normal_approximation(n, b)
        end
        @distribution
      end

      def differential
        return @differential if @differential
        @differential = Hash.new(0)
        (0..limit).each do |a|
          (0..limit).each do |b|
            @differential[b - a] += distribution[b][2] * distribution[a][1]
          end
        end
        @differential
      end

      def self.help
        <<-USAGE
skab [output] poisson [a] [b]
\tWhere: [a] and [b] are integers
\tPlots the poisson distribution for [a] and [b]
        USAGE
      end
      
      private

      attr_reader :a, :b

      def limit
        limit = [a, b].max * 2
      end

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
