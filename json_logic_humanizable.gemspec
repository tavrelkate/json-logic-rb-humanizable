# frozen_string_literal: true
require_relative "lib/json_logic/version"

Gem::Specification.new do |spec|
  spec.name          = "json_logic_humanizable"
  spec.version       = JsonLogic::VERSION
  spec.authors       = ["Tavrel Kate"]

  spec.summary       = "Translate JsonLogic rules into readable sentences."
  spec.description   = "An extension over JsonLogic that translates Rules to human text via a mixin and a small Rule wrapper."
  spec.license       = "MIT"

  # json_logic_humanizable.gemspec
  spec.homepage = "https://github.com/tavrelkate/json_logic_humanizable"

  spec.metadata = {
    "homepage_uri"   => "https://github.com/tavrelkate/json_logic_humanizable",
    "source_code_uri"=> "https://github.com/tavrelkate/json_logic_humanizable",
    "changelog_uri"  => "https://github.com/tavrelkate/json_logic_humanizable/blob/main/CHANGELOG.md",
    "bug_tracker_uri"=> "https://github.com/tavrelkate/json_logic_humanizable/issues"
  }

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    Dir["lib/**/*", "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTION.md"]
  end
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.7"
end
