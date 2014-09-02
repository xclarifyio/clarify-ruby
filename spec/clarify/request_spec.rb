require "spec_helper"
require_relative "../../lib/clarify"

module Clarify

 describe Request do
    before do
      @response = Request.new.create_bundle
    end

    it "should create a new bundle with all blank values" do
      expect(@response.data).to include(:_class, :_links, :id) 
    end
    
    it "should retrieve the bundle created" do
      response = Request.new.fetch_bundle(@response.data[:id])
      expect(response.status).to eql 200
    end
  end

end
