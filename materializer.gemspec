# encoding: UTF-8

$:.push File.expand_path("../lib", __FILE__)
require "materializer/version"

Gem::Specification.new do |s|
  s.name        = "materializer"
  s.version     = Materializer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christopher Meiklejohn"]
  s.email       = ["christopher.meiklejohn@gmail.com"]
  s.homepage    = "https://github.com/cmeiklejohn/materializer"
  s.summary     = %q{Persist serialization in the model.}
  s.description = s.summary

  s.rubyforge_project = "materializer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('rails', '>= 3.1.0.rc4')

  s.add_development_dependency('bundler', '~> 1.0.0')
  s.add_development_dependency('rspec') 
  s.add_development_dependency('rspec-rails') 
  s.add_development_dependency('sqlite3')
  s.add_development_dependency('factory_girl')
  s.add_development_dependency('factory_girl_rails')
  s.add_development_dependency('mocha')
  s.add_development_dependency('appraisal', '~> 0.3.5')
  s.add_development_dependency('timecop')
  s.add_development_dependency('horo') 
  s.add_development_dependency('simplecov') 
  s.add_development_dependency('diesel') 
  s.add_development_dependency('ZenTest') 
  s.add_development_dependency('guard') 
  s.add_development_dependency('guard-rspec')

  if RUBY_PLATFORM =~ /linux/i
    s.add_development_dependency('rb-inotify')
    s.add_development_dependency('libnotify')
  end
end
