require './test/test_helper.rb'
class WorkingGemspecTest < MiniTest::Unit::TestCase
  def valid_working_gemspec_args
    {
      name:    'mygem', # TODO: Deduce this
      version: '0.2.3', # TODO: Deduce MyGem::VERSION (from file?)
      authors: ['Cod Err'],
      github:  'coderr/mygem',
      email:   'foo@example.com',
      deps:     %w(a b c),
      summary: 'Hi.',
      description: 'Hello, how are you?',
    }
  end

  def test_dsl
    gem = nil
    fake_file_list = %w(
      Gemfile
      bin/mygeminate
      lib/mygem.rb
      lib/mygem/version.rb
      test/mygem_test.rb
    )
    version_file_arg = nil
    Working.stub :require_version_file, -> path { version_file_arg = path } do
      Working.stub :git_ls_files, fake_file_list do
        args = valid_working_gemspec_args
        gem = Working.gemspec args
      end
    end
    assert_equal 'mygem', gem.name
    assert_equal 'Hi.', gem.summary
    assert_equal "Hi.\n\nHello, how are you?", gem.description
    assert_equal ['Cod Err'], gem.authors
    assert_equal 'foo@example.com', gem.email
    assert_equal 'https://github.com/coderr/mygem', gem.homepage
    assert_equal '0.2.3', gem.version.to_s
    assert_equal 3, gem.dependencies.size
    assert_equal fake_file_list, gem.files
    assert_equal %w(mygeminate), gem.executables
    assert_equal %w(test/mygem_test.rb), gem.test_files
    assert_equal 'mygem', version_file_arg
  end

  def test_verbose_failure
    args = valid_working_gemspec_args
    required_fields = %w(name authors email version github deps)
    required_fields.each do |e|
      begin
        bad_args = args.dup
        bad_args.delete e.to_sym
        Working.gemspec bad_args
      rescue => err
        assert_match e, err.message
      end
    end

    assert_raises RuntimeError do
      Working.gemspec valid_working_gemspec_args.merge hi: 1
    end
  end

  def test_file_snippet
    actual = Working.file_snippet(__FILE__, /^require/, /^\s*def/)
    assert_equal %(require './test/test_helper.rb'
class WorkingGemspecTest < MiniTest::Unit::TestCase\n), actual
  end

  # This is because I put the gem.summary on the 3rd line of the README.rdoc
  def test_third_line
    assert_equal "  def valid_working_gemspec_args\n",
      Working.file_third_line(__FILE__)
  end
end
