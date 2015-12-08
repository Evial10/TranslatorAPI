# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'TranslatorAPI/version'

Gem::Specification.new do |spec|
  spec.name          = "TranslatorAPI"
  spec.version       = TranslatorAPI::VERSION
  spec.authors       = ["Dmitry Utkin"]
  spec.email         = ["evial10@rambler.ru"]

  spec.summary       = "Ruby gem Yandex API"
  spec.description   = "Ruby gem Yandex API"
  spec.homepage      = "https://github.com/Evial10/TranslatorAPI"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  
  spec.files         = ["lib/TranslatorAPI.rb","lib/TranslatorAPI/Text.rb","lib/TranslatorAPI/version.rb","lib/TranslatorAPI/Error/YandexError.rb","lib/TranslatorAPI/Requests/Post.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
