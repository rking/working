require 'working/test_helper'
# Spork.prefork doesn't like when this is missing
Spork.each_run do
  require 'working'
  require 'working/gemspec'
end
