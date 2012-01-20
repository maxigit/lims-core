# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lims-core/version"

Gem::Specification.new do |s|
  s.name        = "lims-core"
  s.version     = Lims::Core::VERSION
  s.authors     = ["Maxime Bourget"]
  s.email       = ["mb14@sanger.ac.uk"]
  s.homepage    = ""
  s.summary     = %q{Core of new LIMS system}
  s.description = %q{Provide the core classes and persistance needed to build an API used by the pipelines applications.}
  s.description = %q{provides all the necessary to interact with the core database}

  s.rubyforge_project = "lims-core"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_dependency('facets', '2.9.3')

  #development
  s.add_development_dependency('rspec', '~> 2.3.0')
end
