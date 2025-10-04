# frozen_string_literal: true

require "test_helper"

class ConfigTest < Minitest::Test
  def test_vars_regex_mapping_titleizes_last_segment
    JsonLogic::Config.vars[/([^\.]+)$/] = ->(m) { m[1].tr("_", " ").split.map(&:capitalize).join(" ") }
    logic = { "==" => [ { "var" => "customer.first_name" }, "Alice" ] }
    assert_equal "First Name is equal to Alice", JsonLogic::Rule.new(logic).humanize
  end

  def test_operator_overrides
    JsonLogic::Config.operators["in"] = "is one of"
    logic = { "in" => [ { "var" => "currency" }, %w[EUR USD] ] }
    assert_equal "currency is one of EUR, USD", JsonLogic::Rule.new(logic).humanize
  end

  def test_logical_label_override
    JsonLogic::Config.operators["and"] = "AND ALSO"
    logic = { "and" => [ { "==" => [ { "var" => "a" }, 1 ] }, { "==" => [ { "var" => "b" }, 2 ] } ] }
    assert_equal "a is equal to 1 AND ALSO b is equal to 2", JsonLogic::Rule.new(logic).humanize
  end
end
