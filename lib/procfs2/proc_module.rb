# frozen_string_literal: true

require_relative 'proc_item'

module Procfs2
  class ProcModule < ProcItem
    class << self
      def provide(component, as: nil)
        component_label = as || component::LABEL
        define_method component_label do |*args, **kwargs|
          component.build(*args, parent: self, **kwargs)
        end
      end
    end
  end
end
