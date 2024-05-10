# frozen_string_literal: true

require 'test_helper'

class TestProc < Minitest::Test
  def setup
    @proc = Procfs2::Proc.new(root: Test::PROCFS_ROOT)
  end

  def test_it_can_be_instantiated
    assert @proc
    assert_equal Test::PROCFS_ROOT, @proc.root
  end

  def test_it_provides_version_info
    assert @proc.version
    assert_equal File.join(Test::PROCFS_ROOT, 'version'), @proc.version._path
  end

  def test_it_provides_pid
    assert @proc.pid(1)
    assert_equal File.join(Test::PROCFS_ROOT, '1'), @proc.pid(1)._path
  end

  def test_it_provides_net
    assert @proc.net
    assert_equal File.join(Test::PROCFS_ROOT, 'net'), @proc.net._path
  end
end
