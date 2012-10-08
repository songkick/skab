require 'statisfish/models/poisson'
require 'statisfish/models/binomial'

module Statisfish
  module Models
    def self.from_name(name)
      case name
        when 'poisson'
          Poisson
        when 'binomial'
          Binomial
      end
    end
  end
end
