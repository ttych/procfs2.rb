# frozen_string_literal: true

require_relative 'proc_module'
require_relative 'proc_net_tcp'
require_relative 'proc_net_udp'

module Procfs2
  class ProcNet < ProcModule
    LABEL = :net

    provide ProcNetTcp
    provide ProcNetUdp
  end
end
