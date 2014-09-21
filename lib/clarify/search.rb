module Clarify
  class Search < Request

    def perform(query={})
      response = self.class.get("/#{version_name}/search", query: query, headers: headers)
      build_response(response)
    end
    
  end
end
