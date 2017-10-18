# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shamgar_user_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "shamgar_user_manager"
  spec.version       = ShamgarUserManager::VERSION
  spec.authors       = ["Vic Amuso"]
  spec.email         = ["vic@parablesoft.com"]

  spec.summary       = %q{}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'byebug'

  spec.add_development_dependency 'rspec-rails', "~> 3.6.0"
  spec.add_development_dependency 'actionpack', "5.0.2"
  spec.add_development_dependency 'airborne'
  spec.add_development_dependency 'jsonapi-serializers'
  spec.add_development_dependency "sqlite3", '~> 1.3.9'
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "ffaker"
  spec.add_development_dependency "activerecord", "5.0.2"
  spec.add_development_dependency "activesupport", "5.0.2"
  spec.add_development_dependency "email_validator"
  spec.add_development_dependency 'acts_as_paranoid',"0.5.0"
  spec.add_development_dependency 'shoulda-matchers',"3.1.1"
end


