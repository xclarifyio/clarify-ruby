
module Clarify
  # Handles the HTTP response and returns responses. Also raises exceptions
  # around API failures.
  class ResponseFactory
    def make_result(response)
      raise_on_code!(response)

      return Clarify::Responses::NoBody.new(response) if response.body.nil?

      data = JSON.parse(response.body || '')
      klass_for_class(data['_class']).new(data, response)
    rescue KeyError
      raise Clarify::UnrecognizedResponseError, data['_class']
    end

    def raise_on_code!(response)
      return unless response.code.to_i == 401
      fail Clarify::UnauthenticatedError, response
    end

    def klass_for_class(name)
      klasses.fetch name
    end

    def klasses
      {
        'Bundle' => Clarify::Responses::Bundle,
        'Collection' => Clarify::Responses::Collection,
        'Insights' => Clarify::Responses::Insights,
        'Ref' => Clarify::Response,
        'SearchCollection' => Clarify::Responses::SearchCollection,
        'SpokenWordsInsight' => Clarify::Responses::SpokenWordsInsight,
        'SpokenKeywordsInsight' => Clarify::Responses::SpokenKeywordsInsight,
        'Tracks' => Clarify::Responses::Tracks
      }
    end
  end
end
