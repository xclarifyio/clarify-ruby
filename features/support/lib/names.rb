
require 'securerandom'

module ClarifyTests
  # Take names you use in a test and make them unique, guaranteeing two tests
  # can't trample on the same account.
  class Names
    def translate(name)
      "#{uuid}{#{name}}"
    end

    def uuid
      @uuid ||= SecureRandom.uuid
    end
  end
end
