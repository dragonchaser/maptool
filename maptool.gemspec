require_relative 'lib/maptool/version'

Gem::Specification.new do |spec|
  spec.name          = "maptool"
  spec.version       = Maptool::VERSION
  spec.authors       = ["Christian Richter, Elliott HEBERT"]
  spec.email         = ["elliott.hebert.pro@gmail.com"]

  spec.summary       = %q{Maptool is a small tool to generate nethack-style ASCII dungeons. It is a WIP at the moment so expect breaking changes and bugs.}
  spec.homepage      = "https://github.com/dragonchaser/maptool"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/dragonchaser/maptool"
  spec.metadata["changelog_uri"] = "https://github.com/dragonchaser/maptool/changelog.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
