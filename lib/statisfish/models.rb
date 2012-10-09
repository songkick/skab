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

    def self.model_names
      ['poisson', 'binomial']
    end

    def self.help
      <<-HELP
The following models are available: #{model_names.join(', ')}
\tTry `statisfish help model [model] to find out more about a model
      HELP
    end
  end
end
