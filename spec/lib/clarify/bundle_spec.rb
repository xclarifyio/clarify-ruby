module Clarify

 describe Bundle do
   before do
     @response = Bundle.new.create
     @bundle_id = @response.data[:id]
   end

   after do
     Bundle.new.delete(@bundle_id)
   end

   it "should create a new bundle with all blank values" do
     expect(@response.data).to include(:_class, :_links, :id) 
   end
    
   it "should retrieve the bundle created" do
     response = Bundle.new.find(@bundle_id)
     expect(response.status).to eql 200
   end

   it "should find all bundles" do
     response = Bundle.new.find_all
     expect(response.status).to eql 200
    end

    it "should update a bundle" do
      response = Bundle.new.update(@bundle_id, {name: "test"})
      expect(response.status).to eql 202
      expect(response.data.keys).to include(:_class, :_links, :id)
    end
  end

  context "deleting a bundle" do
    it "should delete the bundle" do
      response = Bundle.new.create
      Bundle.new.delete(response.data[:id])
      expect(Bundle.new.find(response.data[:id]).status).to be 404
    end
  end

end

