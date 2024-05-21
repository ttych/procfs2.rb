# frozen_string_literal: true

module Procfs2
  class ProcNetUdpSocket
    HEADERS = %i[
      id
      local_address_port
      remote_address_port
      state
      transmit_receive_queue
      timer_and_jiffies
      retransmit
      uid
      timeout
      inode
      socket_reference_count
      socket_location
      drops
    ].freeze

    STATE_STR = {
      0 => 'UNKNOWN',
      1 => 'ESTABLISHED',
      2 => 'SYN_SENT',
      3 => 'SYN_RECV',
      4 => 'FIN_WAIT1',
      5 => 'FIN_WAIT2',
      6 => 'TIME_WAIT',
      7 => 'CLOSE',
      8 => 'CLOSE_WAIT',
      9 => 'LAST_ACK',
      10 => 'LISTEN',
      11 => 'CLOSING',
      12 => 'NEW_SYN_RECV',
      13 => 'MAX_STATE'
    }.freeze

    attr_reader :id, :local_address, :local_port, :remote_address, :remote_port, :state,
                :transmit_queue, :receive_queue, :uid, :inode, :drops

    def initialize(id:, local_address:, local_port:, remote_address:, remote_port:, state:,
                   transmit_queue:, receive_queue:, uid:, inode:, drops:, **extra)
      @id = id
      @local_address = local_address
      @local_port = local_port
      @remote_address = remote_address
      @remote_port = remote_port
      @state = state
      @transmit_queue = transmit_queue
      @receive_queue = receive_queue
      @uid = uid
      @inode = inode
      @drops = drops

      @extra = extra
    end

    def type
      'udp'
    end

    def state_str
      STATE_STR[state]
    end

    class << self
      def build_from_line(line)
        info = HEADERS.zip(line.strip.split).to_h
        options = {}

        options[:id] = info[:id].chomp(':').to_i
        options[:local_address], options[:local_port] = parse_address_hex(info[:local_address_port])
        options[:remote_address], options[:remote_port] = parse_address_hex(info[:remote_address_port])
        options[:state] = info[:state].hex
        options[:transmit_queue], options[:receive_queue] = info[:transmit_receive_queue].split(':').map(&:hex)
        options[:timer_active], options[:jiffries] = info[:timer_and_jiffies].split(':').map(&:hex)
        options[:retransmit] = info[:retransmit].hex
        options[:uid] = info[:uid].to_i
        options[:timeout] = info[:timeout].to_i
        options[:inode] = info[:inode].to_i
        options[:socket_reference_count] = info[:socket_reference_count].to_i
        options[:socket_location] = info[:socket_location]
        options[:drops] = info[:drops].to_i

        new(**options)
      end

      def parse_address_hex(address_port_hex)
        address_hex, port_hex = address_port_hex.split(':')
        address = [address_hex[6..7],
                   address_hex[4..5],
                   address_hex[2..3],
                   address_hex[0..1]].map(&:hex).join('.')
        port = port_hex.hex
        [address, port]
      end
    end
  end
end
