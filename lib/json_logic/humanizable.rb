# frozen_string_literal: true

module JsonLogic
  module Humanizable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def humanize_json_logic(*attrs, as: nil, suffix: "_human")
        attrs.each do |attr|
          method_name = (as || "#{attr}#{suffix}").to_sym
          define_method(method_name) do
            value = public_send(attr)
            humanize_logic(value)
          end
        end
      end
    end

    def humanize_logic(value)
      return nil if value.nil?
      obj = value.is_a?(String) ? parse_json(value) : value
      explain(obj)
    rescue JSON::ParserError
      value
    end

    def humanize(value)
      humanize_logic(value)
    end

    private

    def parse_json(str)
      require "json"
      JSON.parse(str)
    end

    AND_OPERATORS   = %w[and all].freeze
    OR_OPERATORS    = %w[or any].freeze
    LOGIC_OPERATORS = (AND_OPERATORS + OR_OPERATORS).freeze
    NOT_OPERATOR      = "!"
    IN_OPERATOR       = "in"
    VARIABLE_OPERATOR = "var"
    FACT_OPERATOR     = "fact"

    def explain(logic)
      return logic.to_s unless logic.is_a?(Hash)
      operator, operands = logic.first
      operands ||= []
      case operator
      when *LOGIC_OPERATORS
        joiner = label(normalize(operator))
        operands.map { |operand| explain(operand) rescue operand.inspect }.join(" #{joiner} ")
      when NOT_OPERATOR
        "#{label(NOT_OPERATOR)} (#{explain(operands)})"
      when IN_OPERATOR
        variable, list = operands
        "#{pretty(variable)} #{label(IN_OPERATOR)} #{Array(list).join(', ')}"
      when VARIABLE_OPERATOR
        pretty(operands)
      when FACT_OPERATOR
        "#{pretty(operands)} #{label(logic['operator'])} #{logic['value']}"
      else
        binary(operator, operands) || logic.inspect
      end
    end

    def binary(operator, operands)
      return unless valid_operands?(operands)
      "#{pretty(operands.first)} #{label(operator)} #{operands[1]}"
    end

    def valid_operands?(operands)
      operands.is_a?(Array) && operands.size == 2 && operands.first.is_a?(Hash) && operands.first[VARIABLE_OPERATOR]
    end

    def normalize(operator)
      return "and" if AND_OPERATORS.include?(operator)
      return "or"  if OR_OPERATORS.include?(operator)
      operator
    end

    def pretty(expression)
      extract_variable_name(expression).tap do |base|
        Array(Config.vars).each do |pattern, replacement|
          if pattern.is_a?(Regexp) ? (match = pattern.match(base)) : base == pattern.to_s
            return replacement.is_a?(Proc) ? replacement.call(match || base) : replacement
          end
        end
      end
    end

    def extract_variable_name(expression)
      expression.is_a?(Hash) && expression[VARIABLE_OPERATOR] ? expression[VARIABLE_OPERATOR].to_s : expression.to_s
    end

    def label(operator)
      Config.operators&.[](operator) || operator
    end
  end
end
