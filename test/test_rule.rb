# frozen_string_literal: true

require_relative "test_helper"

class RuleTest < Minitest::Test
  def test_binary_hash
    logic = { ">" => [ { "var" => "age" }, 18 ] }
    assert_equal "age is greater than 18", JsonLogic::Rule.new(logic).humanize
  end

  def test_json_input
    json = %({"in":[{"var":"role"},["admin","editor"]]})
    assert_equal "role is in admin, editor", JsonLogic::Rule.new(json).humanize
  end

  def test_logic_composition_and_or_not
    logic = {
      "and" => [
        { ">=" => [ { "var" => "payment.amount" }, 50 ] },
        {
          "or" => [
            { "in" => [ { "var" => "payment.currency" }, %w[EUR USD] ] },
            { "==" => [ { "var" => "customer.vip" }, true ] }
          ]
        },
        { "!" => { "==" => [ { "var" => "customer.blacklisted" }, true ] } }
      ]
    }
    expected = "payment.amount is greater than or equal to 50 AND payment.currency is in EUR, USD OR customer.vip is equal to true AND NOT (customer.blacklisted is equal to true)"
    assert_equal expected, JsonLogic::Rule.new(logic).humanize
  end

  def test_fact_triplet_simple
    logic = { "fact" => "risk.score", "operator" => "<=", "value" => 300 }
    assert_equal "risk.score is less than or equal to 300", JsonLogic::Rule.new(logic).humanize
  end

  def test_fact_triplet_in_operator_array_literal
    JsonLogic::Config.operators["in"] = "is one of"
    logic = { "fact" => "payment.currency", "operator" => "in", "value" => %w[EUR USD] }
    out = JsonLogic::Rule.new(logic).humanize
    assert_match(/\A.*is one of \["EUR", "USD"\]\z/, out)
  end

  def test_nil_input
    assert_nil JsonLogic::Rule.new(nil).humanize
  end

  def test_unknown_structure_fallback
    logic = { "weird" => { "x" => [1,2,3] } }
    assert_equal logic.inspect, JsonLogic::Rule.new(logic).humanize
  end

  def test_class_helpers
    logic = { "<=" => [ { "var" => "score" }, 10 ] }
    assert_equal "score is less than or equal to 10", JsonLogic::Rule.call(logic)
    assert_equal "score is less than or equal to 10", JsonLogic::Rule[logic]
    assert_equal "score is less than or equal to 10", JsonLogic::Rule.text(logic)
  end
end
