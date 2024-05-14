# frozen_string_literal: true

require 'test_helper'

class TestProcNet < Minitest::Test
  def setup
    @proc = Procfs2::Proc.new(root: Test::PROCFS_ROOT)
    @net = Procfs2::ProcNet.build(parent: @proc)
  end

  def test_it_can_be_accessed_through_proc
    assert @proc.net
  end

  def test_it_can_be_instantiated
    assert @net
    assert_equal File.join(Test::PROCFS_ROOT, 'net'), @net._path
  end

  def test_it_provides_tcp
    assert @net.tcp
    assert_equal File.join(Test::PROCFS_ROOT, 'net', 'tcp'), @net.tcp._path
  end

  def test_it_provides_udp
    assert @net.udp
    assert_equal File.join(Test::PROCFS_ROOT, 'net', 'udp'), @net.udp._path
  end
end
