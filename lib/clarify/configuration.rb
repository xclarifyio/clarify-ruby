module Clarify
  class Configuration
    
    attr_accessor :api_key, :version_name, :version

    def initialize 
      @api_key = 'api key here'
      @version = '1'  # latest version is default
    end

    def version_name
      "v#{@version}"
    end

  end
end
