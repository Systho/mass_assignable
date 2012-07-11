# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mass_assignable"

Gem::Specification.new do |s|
  s.name        = "mass_assignable"
  s.version     = "0.0.2"
  s.authors     = ["Systho"]
  s.email       = ["systho@gmail.com"]
  #s.homepage    = ""
  s.summary     = %q{This gem can be used to easily allow some roles to do mass assignment on AR:Base children}
  s.description = %q{The purpose of this gem is to easily allow some roles like "admin" or "system" to do mass assignment. This can be useful for deserializing records(system) or working with  an admin section whose authenticated users have all privileges}

  s.rubyforge_project = "mass_assignable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"

  s.add_runtime_dependency "activemodel"
  s.add_runtime_dependency "activesupport"
end
