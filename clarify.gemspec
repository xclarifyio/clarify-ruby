# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clarify/version'

Gem::Specification.new do |spec|
  spec.name          = 'clarify'
  spec.version       = Clarify::VERSION
  spec.authors       = ['Clarify Inc.']
  spec.email         = ['support@clarify.io']
  spec.summary       = 'Search audio and video in a few lines of code'
  spec.description   = 'Use the Clarify API to make your audio and video files searchable in just a few lines of code.'
  spec.homepage      = 'http://www.clarify.io'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',             '~> 1.5'
  spec.add_development_dependency 'rake',                '~> 10.0'
  spec.add_development_dependency 'cucumber',            '~> 1.3.0'
  spec.add_development_dependency 'rspec',               '~> 3.0'
  spec.add_development_dependency 'rspec-expectations',  '~> 3.2.0'
  spec.add_development_dependency 'rubocop',             '~> 0.29.0'
  spec.add_development_dependency 'simplecov',           '~> 0.9.0'
end

