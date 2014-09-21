module Clarify
  describe Config do
    before do 
      Clarify.configure do |config|
        config.api_key = ENV['CLARIFY_API_KEY']
        config.version = 5
      end
    end

    it "should set the api_key in configuration" do
      expect(Request.new.api_key).to eql(ENV['CLARIFY_API_KEY'])
    end

    it "should set the version number in the configuration" do
      expect(Request.new.version_name).to eql("v5") 
    end
  end
end

