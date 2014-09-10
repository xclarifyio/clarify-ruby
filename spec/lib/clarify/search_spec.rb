module Clarify
  describe Search do
    before do
      @response = Bundle.new.create
      @bundle_id = @response.data[:id]
      @media_url = "http://media.clarify.io/audio/samples/harvard-sentences-1.wav"
      @response = Track.new.add(@bundle_id, @media_url)
    end

    it "should search for a word in speech" do
      response = Search.new.perform({query: "cat"})
      expect(response.data[:item_results].first[:term_results].first[:matches].first[:hits].size).to eql 2  
    end
  end
end