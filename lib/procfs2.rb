# frozen_string_literal: true

require_relative 'procfs2/version'
require_relative 'procfs2/error'
require_relative 'procfs2/proc'

module Procfs2
  ROOT = '/proc'

  def self.proc(root: ROOT)
    Proc.new(root: root)
  end
end
