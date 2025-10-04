# frozen_string_literal: true

require_relative "humanizable"

module JsonLogic
  class Rule
    include Humanizable

    attr_reader :logic

    def initialize(value)
      @logic = value
    end

    humanize_json_logic :logic

    def to_s
      humanize_logic(@logic).to_s
    end

    def humanize
      to_s
    end

    class << self
      def call(value)
        new(value).humanize
      end
      alias [] call
      alias text call
    end
  end
end
