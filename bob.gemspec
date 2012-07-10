# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bob/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["alexmreis, corelon"]
  gem.email         = ["alex@alexmreis.com, corelon@gmail.com"]
  gem.description   = "A minimalist CI server you can run on any box"
  gem.summary       = "BoB - Break our Build is a minimalist CI server"
  gem.homepage      = "http://github.com/alexmreis/bob"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bob"
  gem.require_paths = ["lib"]
  gem.version       = Bob::VERSION

  #dependencies
  gem.add_dependency 'grit'
  gem.add_dependency 'pony'
  gem.add_dependency 'rake'
  
  #testing
  gem.add_development_dependency('rspec')
end
