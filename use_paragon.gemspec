# frozen_string_literal: true

require_relative "lib/use_paragon/version"

Gem::Specification.new do |spec|
  spec.name          = "use_paragon"
  spec.version       = UseParagon::VERSION
  spec.authors       = ["Eduardo Candanedo"]
  spec.email         = ["eduardo@candanedo.dev"]

  spec.summary       = "Ship every native integration your customers need from your Rails application."
  spec.description   = "Product & engineering teams use Paragon's SDK & embedded
    iPaaS to ship native integrations 7x faster than building in-house. This Gem
    will allow you to seamlessly connect to the Paragon platform via API"
  spec.homepage      = "https://github.com/candanedo/useparagon"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/candanedo/useparagon"
  spec.metadata["changelog_uri"] = "https://github.com/candanedo/useparagon"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
