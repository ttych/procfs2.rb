# frozen_string_literal: true

require_relative 'proc_item'

module Procfs2
  class ProcVersion < ProcItem
    LABEL = :version

    VERSION_RE = /
      (?<kernel>\w+)
      \sversion\s
      (?<version>[\w.-]+)
      \s
      \((?<user>\w+)@(?<host>[\w.-]+)\)
      \s
      \((?<gcc_version>[\w\s\(\).,-]+)\)
      \s
      (?<kernel_type>[\w#\s-]+)
      \s
      (?<timestamp>\w+\s+\w+\s+\d+\s+[\d:]+\s+\w+\s+\d+)
      /x

    def _parse_content
      return unless _raw_content
      return unless (match = _raw_content.match(VERSION_RE))

      @_data = match.names.zip(match.captures).to_h
    end
  end
end
