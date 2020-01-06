
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "env_sync/version"

Gem::Specification.new do |spec|
  spec.name          = "env_sync"
  spec.version       = EnvSync::VERSION
  spec.authors       = ["Yukito Ito"]
  spec.email         = ["yukibukiyou@gmail.com"]

  spec.summary       = "Manage .env file by 1 file"
  spec.description   = "Manage .env file by 1 file"
  spec.homepage      = "https://github.com/ykpythemind/env_sync"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
