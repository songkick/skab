module Skab
  module Models
    class Binomial

      def initialize(args)
        @a_trials = args.shift.to_i
        @a_success = args.shift.to_i
        @b_trials = args.shift.to_i
        @b_success = args.shift.to_i
      end

      def distribution
        return @distribution if @distribution
        @distribution = []
        sums = [0, 0, 0]
        i = 0.0
        while i <= 1000
          @distribution[i] = []
          @distribution[i][0] = i / 1000
          @distribution[i][1] = binomial(@a_trials, @a_success, i / 1000)
          @distribution[i][2] = binomial(@b_trials, @b_success, i / 1000)
          sums[1] += binomial(@a_trials, @a_success, i / 1000)
          sums[2] += binomial(@b_trials, @b_success, i / 1000)
          i += 1
        end
        i = 0.0
        while i <= 1000
          @distribution[i][1] /= sums[1]
          @distribution[i][2] /= sums[2]
          i += 1
        end
        @distribution
      end

      def differential
        return @differential if @differential
        @differential = Hash.new(0)
        i = 0.0
        while i <= 1000
          j = 0.0
          while j <= 1000
            @differential[(j - i) / 1000] += distribution[j][2] * distribution[i][1]
            j += 1
          end
          i += 1
        end
        @differential
      end

      def self.help
        <<-HELP
skab [output] binomial [trials_a] [successes_a] [trials_b] [successes_b]
\tWhere: all parameters are integers
\tPlots the binomial distribution for A and B, given their respective
\tnumber of successes and trials
        HELP
      end

      private

      attr_reader :a, :b

      def binomial(trials, success, rate)
        binomial_coef(trials, success) * 
            (rate ** success) * 
            ((1 - rate) ** (trials - success))
      end

      def binomial_coef(n, k)
        fact(n) / (fact(k) * fact(n - k))
      end

      def fact(n)
        f = 1
        (1..n).each do |i|
          f *= i
        end
        f
      end

    end
  end
end
