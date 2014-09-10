module Clarify
  class Search < Request
 
    def initialize(version="1")
      super(version)
    end

    def perform(query={})
      response = self.class.get("/#{version}/search", query: query, headers: headers)
      build_response(response)
    end
    
  end
end