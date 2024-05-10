# frozen_string_literal: true

require 'test_helper'

class TestProcfs2 < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Procfs2::VERSION
  end

  def test_it_can_be_instantiated
    assert Procfs2.proc
  end

  def test_it_can_be_instantiated_with_another_proc_root_directory
    proc = Procfs2.proc(root: Test::PROCFS_ROOT)

    assert proc
    assert_equal(proc.root, Test::PROCFS_ROOT)
  end
end
