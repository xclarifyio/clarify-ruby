module Clarify

  class Bundle
    
    attr_reader :name, :media_url, :metadata, :audio_channel, :external_id, :notify_url
    
    def create(args = {})
      Request.new.create_bundle(args)
    end

    def find(bundle_id, embed = "")
      Request.new.find_bundle(bundle_id, embed)
    end

    def all(args = {})
      Request.new.find_bundle_all(args)
    end

    def delete(bundle_id)

      Request.new.delete_bundle(bundle_id)
    end

    def update(bundle_id, args)
    end 
    
  end
  
end
