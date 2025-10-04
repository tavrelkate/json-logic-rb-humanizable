# frozen_string_literal: true

module JsonLogic
  module Config
    class << self
      attr_accessor :vars, :operators
    end
  end

  Config.vars = {}

  Config.operators = {
    "==" => "is equal to",
    "!=" => "is not equal to",
    ">"  => "is greater than",
    "<"  => "is less than",
    ">=" => "is greater than or equal to",
    "<=" => "is less than or equal to",
    "in" => "is in",
    "!"  => "NOT",
    "and"=> "AND",
    "or" => "OR"
  }
end
