# frozen_string_literal: true
#
require "test_helper"

class HumanizableMixinTest < Minitest::Test
  class Presenter
    include JsonLogic::Humanizable
    attr_reader :condition
    humanize_json_logic :condition
    def initialize(condition:) = @condition = condition
  end

  def test_generated_reader_hash
    obj = Presenter.new(condition: { ">=" => [ { "var" => "amount" }, 10 ] })
    assert_equal "amount is greater than or equal to 10", obj.condition_human
  end

  def test_generated_reader_json
    json = %({"in":[{"var":"country"},["LT","LV","EE"]]})
    obj = Presenter.new(condition: json)
    assert_equal "country is in LT, LV, EE", obj.condition_human
  end

  def test_humanize_logic_direct
    obj = Presenter.new(condition: nil)
    assert_equal "vip is equal to true", obj.humanize_logic({ "==" => [ { "var" => "vip" }, true ] })
  end
end
