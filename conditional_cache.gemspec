$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "conditional_cache/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "conditional_cache"
  s.version     = ConditionalCache::VERSION
  s.authors     = ["Krishna Manjunath"]
  s.email       = ["krishnam.gubbi@gmail.com"]
  s.homepage    = "https://github.com/manjuk1/conditional_cache"
  s.summary     = "ConditionalCache - A Simple rails plugin to support conditional get."
  s.description = "ConditionalCache - A Simple rails plugin to support conditional get."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"

  s.add_development_dependency "sqlite3"
end
