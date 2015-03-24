
$LOAD_PATH << File.dirname(__FILE__) + '/lib/'
$LOAD_PATH << File.dirname(__FILE__) + '/../../lib/'

require 'simplecov'
require 'clarify'
require 'customer'
require 'exceptions'
require 'curies'

# EnvHelpers is
class EnvHelpers
  def customer
    @customer ||= ClarifyTests::Customer.new
  end

  def exceptions
    @exceptions ||= ClarifyTests::Exceptions.new
  end

  def curies
    @curies ||= ClarifyTests::Curies.new
  end

  def names
    @names ||= ClarifyTests::Names.new
  end
end

World do
  EnvHelpers.new
end

After do
  exceptions.raise_pending!
end
