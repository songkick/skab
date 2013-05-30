module Skab
  require ROOT + '/skab/models/base'
  require ROOT + '/skab/models/poisson'
  require ROOT + '/skab/models/binomial'
  
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
