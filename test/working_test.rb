require './test/test_helper.rb'
class WorkingTest < MiniTest::Unit::TestCase
  def test_file_snippet
    actual = Working.file_snippet(__FILE__, /^require/, /^class/)
    assert_equal "require './test/test_helper.rb'\n", actual
  end

  # This is because I put the gem.summary on the 3rd line of the README.rdoc
  def test_third_line
    assert_equal "  def test_file_snippet\n", Working.file_third_line(__FILE__)
  end
end
