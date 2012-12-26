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

  [
    'minitest', # Much easier to work with in the REPL (compared to RSpec)
    'turn', # colorized minitest output
    'pry-de', # Pull in pry-full plus a few choice bits. More to come
    'guard',
    'guard-bundler',
    'guard-spork',
    # TODO 'guard-minitest', github: 'rking/guard-minitest'
    'spork-minitest',
    'rb-inotify',
    'rb-fsevent',
    'pry-rails',
    'rake',
  ].each do |dep| gem.add_dependency dep end
end
