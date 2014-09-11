require "clarify/version"
require "clarify/configuration"
require "clarify/bundle"
require "clarify/request"
require "clarify/metadata"
require "clarify/track"
require "clarify/search"

module Clarify
  class << self
    attr_accessor :configuration
  end
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
