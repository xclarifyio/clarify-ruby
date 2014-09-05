require_relative "../../lib/clarify"

module Clarify

 describe Request do
   before do
     @response = Request.new.create_bundle
     @bundle_id = @response.data[:id]
   end

   after do
     Request.new.delete_bundle(@bundle_id)
   end

   it "should create a new bundle with all blank values" do
     expect(@response.data).to include(:_class, :_links, :id) 
   end
    
   it "should retrieve the bundle created" do
     response = Request.new.find_bundle(@bundle_id)
     expect(response.status).to eql 200
   end

   it "should find all bundles" do
     response = Request.new.find_bundle_all
     expect(response.status).to eql 200
    end

    it "should update a bundle" do
      response = Request.new.update_bundle(@bundle_id, {name: "test"})
    #  expect(response.status).to eql 201
      expect(response.data).to eql "blah"
    end
  end

  context "deleting a bundle" do

    it "should delete the bundle" do
      response = Request.new.create_bundle
      Request.new.delete_bundle(response.data[:id])
      expect(Request.new.find_bundle(response.data[:id]).status).to be 404
    end

  end

end
