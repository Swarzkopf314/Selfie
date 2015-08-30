# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'selfie_chain/version'

Gem::Specification.new do |spec|
  spec.name          = "selfie_chain"
  spec.version       = SelfieChain::VERSION
  spec.authors       = ["Maciej Satkiewicz"]
  spec.email         = ["msatkiewicz@gmail.com"]

  spec.summary       = %q{Adds Object#selfie (and SelfieChain < BasicObject) to complement ternary operator, null guard and Rails' :try method at once}
  spec.description   = %q{I realised that there are use cases, that the above mentioned tools fail to address in sufficently elegant way. See README.md and https://github.com/swarzkopf314/selfie_chain for more details.}
  spec.homepage      = "https://github.com/swarzkopf314/selfie_chain"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"

end
