module Clarify

  class Bundle
    
    attr_reader :name, :media_url, :metadata, :audio_channel, :external_id, :notify_url
    
    def create(args = {})
      Request.new.create_bundle(args)
    end

    def fetch(bundle_id, embed = "")
      Request.new.fetch(bundle_id, embed)
    end
  end
  
end
