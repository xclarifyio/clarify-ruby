# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clarify/version'

Gem::Specification.new do |spec|
  spec.name          = 'clarify'
  spec.version       = Clarify::VERSION
  spec.authors       = ['rubygeek']
  spec.email         = ['nola@rubygeek.com']
  spec.summary       = 'Search audio and video in a few lines of code'
  spec.description   = 'Use the Clarify API to make your audio and video files searchable in just a few lines of code.'
  spec.homepage      = 'http://www.clarify.io'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.13', '>= 0.13.1'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.0', '>= 10.0.0'
  spec.add_development_dependency 'rspec',  '~> 3.0', '>= 3.0.0'
  spec.add_development_dependency 'debugger', '~> 1.6', '>= 1.6.8'
end
