module Skab
  module Models
    class Binomial < Base

      def initialize(args)
        @a_trials = args.shift.to_i
        @a_success = args.shift.to_i
        @b_trials = args.shift.to_i
        @b_success = args.shift.to_i
        @fact = { }
        @optims = args.shift || {:cache_binomial => true, :cache_binomial_coef => true}
      end

      def reset
        @distribution, @differential = nil, nil
        @_binomial, @_binomial_coefs = nil, nil
      end

      NUM_SUBDIVS = 1000

      def distribution
        return @distribution if @distribution
        @distribution = []
        sums = [0, 0, 0]
        i = 0.0
        while i <= NUM_SUBDIVS
          i_subdivided = i / NUM_SUBDIVS
          bin_a = binomial(@a_trials, @a_success, i_subdivided)
          bin_b = binomial(@b_trials, @b_success, i_subdivided)
          @distribution[i] = []
          @distribution[i][0] = i_subdivided
          @distribution[i][1] = bin_a
          @distribution[i][2] = bin_b
          sums[1] += bin_a
          sums[2] += bin_b
          i += 1
        end
        i = 0.0
        while i <= NUM_SUBDIVS
          @distribution[i][1] /= sums[1]
          @distribution[i][1] *= NUM_SUBDIVS
          @distribution[i][2] /= sums[2]
          @distribution[i][2] *= NUM_SUBDIVS
          i += 1
        end
        @distribution
      end

      def differential
        return @differential if @differential
        @differential = Hash.new(0)
        i = 0.0
        while i <= NUM_SUBDIVS
          j = 0.0
          while j <= NUM_SUBDIVS
            @differential[(j - i) / NUM_SUBDIVS] += distribution[j][2] * distribution[i][1] / NUM_SUBDIVS
            j += 1
          end
          i += 1
        end
        @differential
      end

      def percentile(p)
        sum = 0.0
        Hash[differential.sort].each do |k, v|
          sum += v
          if sum >= p * NUM_SUBDIVS
            return k
          end
        end
        percentile
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
        return binomial_impl(trials, success, rate) unless @optims[:cache_binomial]
        @_binomials ||= {}

        key = "#{trials}_#{success}_#{rate}".to_sym
        unless @_binomials[key]
          bin = binomial_impl(trials, success, rate)
          @_binomials[key] = bin
          @_binomials["#{trials}_#{trials - success}_#{1 - rate}".to_sym] = bin
        end
        @_binomials[key]
      end

      def binomial_coef(n, k)
        return binomial_coef_impl(n, k) unless @optims[:cache_binomial_coef]
        @_binomial_coefs ||= {}

        key = "#{n}_#{k}".to_sym
        unless @_binomial_coefs[key]
          coef = binomial_coef_impl(n, k)
          @_binomial_coefs[key] = coef
          @_binomial_coefs["#{n}_#{n - k}".to_sym] = coef
        end
        @_binomial_coefs[key]
      end

      def binomial_impl(trials, success, rate)
        binomial_coef(trials, success) *
            (rate ** success) *
            ((1 - rate) ** (trials - success))
      end

      def binomial_coef_impl(n, k)
        factorial(n) / (factorial(k) * factorial(n - k))
      end
    end
  end
end