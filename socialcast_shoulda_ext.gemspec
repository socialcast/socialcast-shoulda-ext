# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "shoulda_ext/version"

Gem::Specification.new do |s|
  s.name        = "socialcast_shoulda_ext"
  s.version     = ShouldaExt::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Geoffrey Hichborn"]
  s.email       = ["geoff@socialcast.com"]
  s.homepage    = "http://github.com/socialcast/socialcast-shoulda-ext"
  s.summary     = %q{adds new shoulda matchers and assertions}
  s.description = File.read('README')

  s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.0"])
  s.add_runtime_dependency(%q<shoulda>, [">= 2.11.1"])

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
