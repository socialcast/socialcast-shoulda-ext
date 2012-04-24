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
  s.description = File.read('README.rdoc')

  s.add_dependency(%q<shoulda>, ["~> 2.11.3"])

  %w[activerecord].each do |lib|
    dep = case ENV[lib]
          when 'stable', nil then nil
          when /(\d+\.)+\d+/ then ["~> " + ENV[lib]]
          else [">= 3.0"]
          end
    s.add_runtime_dependency(lib, dep)
  end

  %w[rails].each do |lib|
    dep = case ENV[lib]
          when 'stable', nil then nil
          when /(\d+\.)+\d+/ then ["~> " + ENV[lib]]
          else [">= 3.0"]
          end
    s.add_development_dependency(lib, dep)
  end
  s.add_development_dependency 'json', ">= 0"
  s.add_development_dependency 'bundler', ">= 0"
  s.add_development_dependency 'mocha', ">= 0"
  s.add_development_dependency 'sqlite3', "~> 1.3.2"
  

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
