
module ClarifyTests
  # The Curies class helps improve readability in URL-based tests by
  # introducing a replacable reference.
  class Curies
    def initialize
      @curies = {}
    end

    def []=(name, value)
      @curies["[#{name}]"] = value
    end

    def resolve(url)
      return url unless url[0] == '['
      @curies.fetch(url)
    end
  end
end
