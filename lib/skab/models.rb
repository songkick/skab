require 'skab/models/poisson'
require 'skab/models/binomial'

module Skab
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
\tTry `skab help model [model] to find out more about a model
      HELP
    end
  end
end
