module Clarify

  describe Track do 

    before do
      bundle = Bundle.new.create
      @bundle_id = bundle.data[:id]
    end

    after do
      Bundle.new.delete(@bundle_id)
    end

    context "adding tracks and getting tracks for bundle" do
      before do
        @media_url = "http://media.clarify.io/audio/samples/harvard-sentences-1.wav"
        @response = Track.new.add(@bundle_id, @media_url)
      end
      it "should be successful" do
        expect(@response.status).to eql 201
        expect(@response.data.keys).to include(:_class, :_links)
      end
      it "should list track in bundle" do
        response = Track.new.all(@bundle_id)
        expect(response.data[:tracks]).to be_an_instance_of(Array)
        expect(response.data[:tracks][0][:media_url]).to eql @media_url
      end    
    end

    context "adding a track and deleting all tracks for bundle" do
      before do
        @media_url = "http://media.clarify.io/audio/samples/harvard-sentences-1.wav"
        @add_response = Track.new.add(@bundle_id, @media_url)
        @del_response = Track.new.delete(@bundle_id)
      end
      it "should be successful" do
        expect(@del_response.status).to eql 204
      end
      it "should not be in bundle" do
        response = Track.new.all(@bundle_id)
        expect(response.data[:tracks]).to be_empty
      end    
    end

    context "adding a track and finding by track_id" do
      before do
        media_url = "http://media.clarify.io/audio/samples/harvard-sentences-1.wav"
        Track.new.add(@bundle_id, media_url)

        all_tracks = Track.new.all(@bundle_id)
        
        @track_id = all_tracks.data[:tracks].first[:id]
        @find_response = Track.new.find(@bundle_id, @track_id)
      end
      it "should be successful" do
        expect(@find_response.status).to eql 200
      end
      it "should have some keys and duration value" do
        expect(@find_response.data.keys).to include(:audio_channel,:audio_language, :duration)
        expect(@find_response.data[:duration]).to eql  64.422875
      end
    end

    context "adding a track and deleting by delete_by_id  " do
      before do
        media_url = "http://media.clarify.io/audio/samples/harvard-sentences-1.wav"
        Track.new.add(@bundle_id, media_url)

        all_tracks = Track.new.all(@bundle_id)
        
        @track_id = all_tracks.data[:tracks].first[:id]
        @find_response = Track.new.delete_by_id(@bundle_id, @track_id)
      end
      it "should be successful" do
        expect(@find_response.status).to eql 204
      end
    end
  end

end

