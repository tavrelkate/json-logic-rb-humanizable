# frozen_string_literal: true
require_relative "lib/json_logic/version"

Gem::Specification.new do |spec|
  spec.name          = "json_logic_humanizable"
  spec.version       = JsonLogic::VERSION
  spec.authors       = ["Your Name"]
  spec.email         = ["you@example.com"]

  spec.summary       = "Human-readable extension for JsonLogic (mixin + Expression class)"
  spec.description   = "An extension over JsonLogic that renders expressions to human text via a mixin and a small Expression wrapper."
  spec.homepage      = "https://jsonlogic.com/"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    Dir["lib/**/*", "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTION.md"]
  end
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.7"
end
