# frozen_string_literal: true

require_relative "lib/stripe_platform/client/version"

Gem::Specification.new do |spec|
  spec.name          = "stripe_platform-client"
  spec.version       = StripePlatform::Client::VERSION
  spec.authors       = ["Nate Klaiber"]
  spec.email         = ["nate@deviceindependent.com.com"]

  spec.summary       = "Interacting with the Stripe Platform"
  spec.description   = "Interacting with the Stripe Platform"
  spec.homepage      = "https://github.com/nateklaiber/stripe-platform-client"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nateklaiber/stripe-platform-client"
  spec.metadata["changelog_uri"] = "https://github.com/nateklaiber/stripe-platform-client.git/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("bundler", "~> 1.7")
  spec.add_development_dependency("rake", ">= 12.3.3")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("yard")
  spec.add_development_dependency("webmock")

  spec.add_dependency('faraday_middleware')
  spec.add_dependency('multi_json')
  spec.add_dependency('dotenv')
  spec.add_dependency('restless_router')
  spec.add_dependency('addressable')
  spec.add_dependency("tzinfo", ">= 0.3.37")
  spec.add_dependency('ruby-units')
  spec.add_dependency('timezone')
  spec.add_dependency('faraday')
  spec.add_dependency("terminal-table")
  spec.add_dependency('mimemagic')
  spec.add_dependency('mime-types')
  spec.add_dependency('rack')

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
