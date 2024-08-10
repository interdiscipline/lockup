# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lockup/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lockup"
  s.version     = Lockup::VERSION
  s.authors     = ["Interdiscipline"]
  s.email       = ["hello@interdiscipline.com"]
  s.homepage    = "http://lockup.interdiscipline.com"
  s.summary     = "Lock staging servers from search engines and prying eyes."
  s.description = "A simple gem to more elegantly place a staging server or other in-progress application behind a basic codeword. It’s easy to implement, share with clients/collaborators, and more beautiful than the typical password-protection sheet."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 3"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'byebug'
end
