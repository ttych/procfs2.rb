# frozen_string_literal: true

require_relative 'proc_item'
require_relative 'proc_fd_id'

module Procfs2
  class ProcFd < ProcItem
    LABEL = :fd

    def _load_content
      @_data = []
      Dir.foreach(_path) do |fd_entry|
        next if ['.', '..'].include?(fd_entry)

        fd_path = File.join(_path, fd_entry)
        fd_stat = File.stat(fd_path)

        @_data << ProcFdId.new(id: fd_entry, path: fd_path, stat: fd_stat)
      end
    end

    def id(id)
      return unless _data

      _data.find { |element| element.id.to_s == id.to_s }
    end

    def each(&block)
      _data&.each(&block)
    end

    include Enumerable
  end
end
