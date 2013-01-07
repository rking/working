= Working

Whoa!! ☈king's opinionated rig for Ruby dev.

== Basic Idea

- Opinionatedly uses MiniTest for everything. It makes better in-memory structures than RSpec, and is therefore better for the goals of https://github.com/pry/pry/wiki/pry-de
- 1:1 mapping between stuff in `lib/` or `app/` and the `test/` dirs.
- Guard for test running (`bundle exec guard`)
- Spork in effect for faster runs

== See also:

http://github.com/rking/working-rails

== Example uses:

- https://github.com/rking/demo-ruby-tests
- https://github.com/rking/monkeynote
- https://github.com/rking/terminal-info

== Installation

Add this line to your application's Gemfile:

    gem 'working'

And then execute:

    bundle
    working-init # this tinkers with several files (verbosely)

== TODO

Explain the parts.
