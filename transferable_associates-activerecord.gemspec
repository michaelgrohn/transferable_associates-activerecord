# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transferable_associates-activerecord/version'

Gem::Specification.new do |gem|
  gem.name          = "transferable_associates-activerecord"
  gem.version       = TransferableAssociates::Activerecord::VERSION
  gem.authors       = "Michael Grohn"
  gem.email         = "michael@grohn.info"
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/michaelgrohn/transferable_associates-activerecord"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
