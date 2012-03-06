# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cupid"

Gem::Specification.new do |s|
  s.name        = "cupid"
  s.version     = Cupid::VERSION
  s.authors     = ["Albert Callarisa Roca"]
  s.email       = ["albert@acroca.com"]
  s.homepage    = "http://github.com/acroca/cupid"
  s.summary     = %q{Pair-programming rotation}
  s.description = %q{Auto generates rotations for a pair-programming team}

  s.rubyforge_project = "cupid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end