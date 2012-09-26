# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scamp-campfire/version"

Gem::Specification.new do |s|
  s.name        = "scamp-campfire"
  s.version     = Scamp::Campfire::VERSION
  s.authors     = ["Adam Holt"]
  s.email       = ["me@adamholt.co.uk"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "scamp-campfire"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "em-campfire"
  s.add_dependency "scamp"
  s.add_dependency "eventmachine", '~> 1.0'

  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "rake"
end
