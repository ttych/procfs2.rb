# frozen_string_literal: true

require_relative 'proc_module'
require_relative 'proc_version'
require_relative 'proc_pid'
require_relative 'proc_net'

module Procfs2
  class Proc < ProcModule
    attr_reader :root

    def initialize(root:)
      @root = root

      super(parent: nil)
    end

    def _path
      root.to_s
    end

    provide ProcVersion
    provide ProcPid
    provide ProcNet
  end
end
