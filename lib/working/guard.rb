Guard::Dsl.new.instance_eval do
  # Rerun bundler, if needed
  guard 'bundler' do watch /^(Gemfile|.*\.gemspec)$/ end
  # These reboot spork completely
  guard 'spork', minitest: true, test_unit: false do
    watch /Gemfile(?:\.lock)?/
  end
  guard 'sporkminitest' do
    # Minitest::Unit style test files
    watch %r|^test/.*_test\.rb|
    watch %r|^lib/(.*)\.rb| do |m| "test/#{m[1]}_test.rb" end
    # Rerun all on test_helper change
    watch %r|^test/test_helper\.rb| do 'test' end
    # Rails app/ dir mapping directly parallel to test/* dirs.
    #   Assumes all test/* dir names are the same as the dirs in app/*
    #   Will need adjustment if you use app/controllers ⇒ test/functional, etc.
    watch %r|^app/(.*)\.rb| do |m| "test/#{m[1]}_test.rb" end
  end
end
