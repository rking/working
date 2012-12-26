require 'minitest/autorun'
if ENV['test_rescue']
  require 'pry-rescue/minitest'
else
  warn "export test_rescue=1 # to get pry-rescue on test failures"
end
require 'turn'
$:.unshift './lib'
Turn.config do |c|
  c.format  = :pretty
  # turn on invoke/execute tracing, enable full backtrace
  # c.trace   = true
end
