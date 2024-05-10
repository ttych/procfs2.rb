# frozen_string_literal: true

require_relative 'proc_module'
require_relative 'proc_fd'

module Procfs2
  class ProcPid < ProcModule
    LABEL = :pid

    attr_reader :pid

    def initialize(pid:, parent:)
      @pid = pid
      super(parent: parent)
    end

    def _filename
      pid.to_s
    end

    provide ProcFd

    class << self
      def build(pid, parent:)
        new(pid: pid, parent: parent)
      end
    end
  end
end
