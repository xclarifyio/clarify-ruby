
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
      klasses = {
        'Collection' => Clarify::Responses::Collection,
        'SearchCollection' => Clarify::Responses::SearchCollection,
        'Bundle' => Clarify::Responses::Bundle,
        'Tracks' => Clarify::Responses::Tracks,
        'Ref' => Clarify::Response
      }

      klasses.fetch name
    end
  end
end
