# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lockup/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lockup"
  s.version     = Lockup::VERSION
  s.authors     = ["gb Studio"]
  s.email       = ["hello@grantblakeman.com"]
  s.homepage    = "http://lockupgem.com"
  s.summary     = "Lock staging servers from search engines and prying eyes."
  s.description = "A simple gem to more elegantly place a staging server or other in-progress application behind a basic codeword. It’s easy to implement, share with clients/collaborators, and more beautiful than the typical password-protection sheet."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 3", "< 6"

  s.add_development_dependency 'rspec-rails', "~> 3.5"
  s.add_development_dependency 'capybara', "~> 2.9"
  s.add_development_dependency 'launchy' # To use Capybara's `save_and_open_page`
  s.add_development_dependency 'byebug'
end
