# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest/autorun"
require "json_logic"

DEFAULT_OPERATORS = {
  "==" => "is equal to",
  "!=" => "is not equal to",
  ">"  => "is greater than",
  "<"  => "is less than",
  ">=" => "is greater than or equal to",
  "<=" => "is less than or equal to",
  "in" => "is in",
  "!"  => "NOT",
  "and"=> "AND",
  "or"  => "OR"
}

class Minitest::Test
  def setup
    JsonLogic::Config.operators = DEFAULT_OPERATORS.dup
    JsonLogic::Config.vars = {}
  end
end
