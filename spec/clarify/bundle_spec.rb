require "spec_helper"
require_relative "../../lib/clarify.rb"

module Clarify

  describe Bundle do

    before do
      @bundle = Bundle.new   
    end

    after do
      
    end

    it "should make a bundle with all blank attributes" do
      @response = @bundle.create
      expect(@response.status).to eql 201
      expect(@response.data).to include(:_class, :_links, :id)
    end

    it "should find a bundle by id" do
      @response = @bundle.create
      id = @response.data[:id]
      found = @bundle.find(id)
      expect(found.data[:id]).to eql id
    end

    it "should find all the bundles created" do
      @response = @bundle.create
      all_response = @bundle.all
      expect(all_response.status).to eql 200
      expect(all_response.data[:_links][:items]).to_not be_nil 
    end

    it "should delete the bundle" do
      response = @bundle.create
      deleted_bundle = @bundle.delete(response.data[:id])
      expect(deleted_bundle.status).to eql 204
      expect(deleted_bundle.data).to be_empty
    end 
  end
  
end

