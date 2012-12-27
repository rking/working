# -*- encoding: utf-8 -*-
$:.unshift './lib'
require 'working/version'

Gem::Specification.new do |gem|
  gem.name          = "working"
  gem.version       = Working::VERSION
  gem.authors       = %w(☈king)
  gem.email         = %w(rking-working@sharpsaw.org)
  gem.summary       = gem.description = %q{Whoa — ☈king's rig}
  gem.homepage      = 'https://github.com/rking/working'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{|f| File.basename f}
  gem.test_files    = gem.files.grep %r{^ test|spec|features/}
  gem.require_paths = ['lib']

  [
    'pry-de', # Pull in pry-full plus a few choice bits. More to come
    'beg', # 'beg' script to run bundle exec guard; fakes it when necessary
    'minitest', # Much easier to work with in the REPL (compared to RSpec)
    'turn', # colorized minitest output
    'guard-sporkminitest', # Run tests in long-running process, for speed
    'guard-bundler', # Watch Gemfile, *.gemspec to run 'bundle install'
    'rake',
  ].each do |dep| gem.add_dependency dep end
end
