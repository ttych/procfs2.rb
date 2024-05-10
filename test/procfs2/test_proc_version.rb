# frozen_string_literal: true

require 'test_helper'

class TestProcVersion < Minitest::Test
  def setup
    @proc = Procfs2::Proc.new(root: Test::PROCFS_ROOT)
    @version = Procfs2::ProcVersion.build(parent: @proc)
  end

  def test_it_can_be_instantiated
    assert @version
    assert_equal File.join(Test::PROCFS_ROOT, 'version'), @version._path
  end

  def test_it_gives_access_to_raw_content
    assert @version._raw_content
    assert_match(/^Linux version 6.5.0-27-generic /, @version._raw_content)
  end

  def test_it_extracts_kernel
    assert_equal 'Linux', @version.kernel
  end

  def test_it_extracts_version
    assert_equal '6.5.0-27-generic', @version.version
  end

  def test_it_extracts_user
    assert_equal 'buildd', @version.user
  end

  def test_it_extracts_host
    assert_equal 'lcy02-amd64-059', @version.host
  end

  def test_it_extracts_timestamp
    assert_equal 'Thu Mar  7 18:21:00 UTC 2024', @version.timestamp
  end
end
