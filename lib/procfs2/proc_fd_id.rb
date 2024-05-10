# frozen_string_literal: true

module Procfs2
  class ProcFdId
    attr_reader :id, :_path, :_stat

    def initialize(id:, path:, stat:)
      @id = id
      @_path = path
      @_stat = stat
    end

    def type
      _stat&.ftype
    end

    def inode
      _stat.ino
    end
  end
end
