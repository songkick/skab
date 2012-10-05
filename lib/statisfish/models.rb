require 'statisfish/models/poisson'

module Statisfish
  module Models
    def self.from_name(name)
      case name
        when 'poisson'
          Poisson.new
      end
    end
  end
end
