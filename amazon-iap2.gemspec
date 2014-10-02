# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amazon/iap2/version'

Gem::Specification.new do |spec|
  spec.name          = 'amazon-iap2'
  spec.version       = Amazon::Iap2::VERSION
  spec.authors       = ['Blinkist', 'DailyBurn']
  spec.email         = ['sj@blinkist.com']
  spec.description   = %q{Verify Amazon in app purchases with IAP 2}
  spec.summary       = %q{Verify Amazon in app purchases with IAP 2}
  spec.homepage      = 'https://github.com/blinkist/amazon-iap2'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
end
