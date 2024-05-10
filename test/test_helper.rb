# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::HTMLFormatter]
)

SimpleCov.start do
  add_filter '/test/'
end

require 'procfs2'

require_relative 'procfs2_test_context'

require 'minitest/autorun'
