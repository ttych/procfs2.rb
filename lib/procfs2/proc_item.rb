# frozen_string_literal: true

module Procfs2
  class ProcItem
    attr_reader :_parent, :_data

    def initialize(parent:)
      @_parent = parent
      @_data = nil

      _initialize_content
    end

    def _filename
      self.class::LABEL.to_s
    end

    def _path
      File.join([_parent&._path, _filename].compact)
    end

    def _raw_content
      @_raw_content ||= File.read(_path) if File.file?(_path)
      @_raw_content ||= ''
      @_raw_content
    end

    private

    def _initialize_content
      _load_content
      _parse_content
    end

    def _load_content
      raise Procfs2::Error, "proc resource at `#{_path}` does not exist" unless File.exist?(_path)

      _raw_content
    end

    def _parse_content; end

    def method_missing(method, *args, **kwargs)
      if _data.respond_to?(:key?)
        return _data[method.to_sym] if _data.key?(method.to_sym)
        return _data[method.to_s] if _data.key?(method.to_s)
      end

      super
    end

    def respond_to_missing?(method, *)
      if _data.respond_to?(:key?) && (_data.key?(method.to_sym) || _data.key?(method.to_s))
        return True
      end

      super
    end

    class << self
      def build(parent:)
        new(parent: parent)
      end
    end
  end
end
