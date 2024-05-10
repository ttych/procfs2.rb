# frozen_string_literal: true

require_relative 'proc_item'
require_relative 'proc_net_tcp_socket'

module Procfs2
  class ProcNetTcp < ProcItem
    LABEL = :tcp

    def _load_content
      @_data = []

      lines = _raw_content.lines
      lines.shift

      @_data = lines.map { |socket_line| ProcNetTcpSocket.build_from_line(socket_line) }
    end

    def by_id(id)
      @_data.find { |socket| socket.id == id.to_i }
    end

    def by_inode(inode)
      @_data.find { |socket| socket.inode == inode.to_i }
    end

    def each(&block)
      _data&.each(&block)
    end

    include Enumerable
  end
end
