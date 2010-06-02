require 'fileutils'

#
def setup_test(framework, required=false, name=nil)
  text = ''
  text << "require '#{required}'\n" if required
  text << <<-HERE
class TestTest < #{framework}::Unit::TestCase
#{standard_test_body}
end
  HERE
  #name = framwwork.downcase
  #name = name + '_required' if requires
  save_test(text, name)
end

#
def save_test(text, name=nil)
  file = File.join('tmp', name || 'test.rb')
  FileUtils.mkdir_p('tmp')
  File.open(file, 'w'){ |f| f << text }
end

#
def standard_test_body
<<-HERE
  def test_pass
    assert_equal(1,1)
  end
HERE
end

#
def guanlent_test_body
<<-HERE
  def test_pass
    assert_equal(1,1)
  end

  def test_fail
    assert_equal(1,2)
  end

  def test_error
    raise
  end
HERE
end

#
def setup_outline_test
  text = <<-HERE
class OutlineTest < Test::Unit::TestCase
  def test_sample_pass
    puts "You should not see me"
    assert_equal(1,1)
  end
  def test_sample_fail
    puts "You should see me"
    assert_equal(1,2)
  end
end
  HERE
  save_test(text, 'outline_test.rb')
end

