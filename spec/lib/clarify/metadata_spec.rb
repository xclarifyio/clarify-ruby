module Clarify

  describe Metadata do
    before do
      bundle = Bundle.new.create
      @bundle_id = bundle.data[:id]
    end

    after do
      Bundle.new.delete(@bundle_id)
    end
    
    it "should retrieve the metadata for bundle" do
      metadata = Metadata.new.find(@bundle_id)
      expect(metadata.status).to eql 200
    end

    it "should update a bundle" do
      metadata = Metadata.new.update(@bundle_id, '{"meta": 1}')
      expect(metadata.status).to eql 202
      expect(metadata.data.keys).to include(:_class, :_links)
    end
  end

  context "deleting metadata" do
    it "should delete the metadata" do
      bundle = Bundle.new.create
      bundle_id = bundle.data[:id]
      
      Metadata.new.update(bundle_id, '{"meta": 1}')
      metadata_before  = Metadata.new.find(bundle_id)         
      expect(metadata_before.data[:data].keys).to include :meta

      metadata_after = Metadata.new.delete(bundle_id)
      expect(metadata_after.status).to eq 204
      expect(metadata_after.data).to be_empty
    end
  end

end

