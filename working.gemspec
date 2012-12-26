# -*- encoding: utf-8 -*-
$:.unshift './lib'
require 'working/version'

Gem::Specification.new do |gem|
  gem.name          = "working"
  gem.version       = Working::VERSION
  gem.authors       = %w(☈king)
  gem.email         = %w(rking-working@sharpsaw.org)
  gem.summary       = %q{Whoa — ☈king's rig}
  gem.description   = %q{Learning as I go}
  gem.homepage      = 'https://github.com/rking/working'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{|f| File.basename f}
  gem.test_files    = gem.files.grep %r{^ test|spec|features/}
  gem.require_paths = ['lib']
end
