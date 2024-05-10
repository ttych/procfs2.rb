# frozen_string_literal: true

require 'test_helper'

class TestProcPid < Minitest::Test
  def setup
    @proc = Procfs2::Proc.new(root: Test::PROCFS_ROOT)
    @pid = Procfs2::ProcPid.build('self', parent: @proc)
  end

  def test_it_can_be_instantiated
    assert @pid
    assert_equal File.join(Test::PROCFS_ROOT, 'self'), @pid._path
  end

  def test_it_provides_fd
    assert @pid.fd
    assert_equal File.join(Test::PROCFS_ROOT, 'self/fd'), @pid.fd._path
  end
end
