require 'bundler/gem_tasks'
task default: :test
task :test do
  Dir['test/**/*_test.rb'].each{|e| load e}
end
