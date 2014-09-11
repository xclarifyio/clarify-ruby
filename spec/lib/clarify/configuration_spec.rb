module Clarify
  describe Config do
    before do 
      Clarify.configure do |config|
        config.api_key = ENV['CLARIFY_API_KEY']
      end
    end

    it "should set the api_key in configuration" do
      expect(Request.new.api_key).to eql(ENV['CLARIFY_API_KEY'])
    end
  end
end

