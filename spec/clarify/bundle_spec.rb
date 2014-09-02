require "spec_helper"
require_relative "../../lib/clarify.rb"

module Clarify

  describe Bundle do

    before do
      @bundle = Bundle.new   
    end

    it "should make a bundle with all blank attributes" do
      response = @bundle.create
      expect(response.status).to eql 201
      expect(response.data).to include(:_class, :_links, :id)
    end

   
  end
end
