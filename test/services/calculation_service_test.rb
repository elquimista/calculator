require "test_helper"

class CalculationServiceTest < ActiveSupport::TestCase
  test "expression with single number" do
    assert_equal 3, CalculationService.call('3')
  end

  test "expression with same operator precedence" do
    assert_equal 3, CalculationService.call('1+2')
    assert_equal -7, CalculationService.call('1+2-10')
  end

  test "expression with different operator precedence" do
    assert_equal 7, CalculationService.call('1+2*3')
    assert_equal 6.5, CalculationService.call('1+2*3-4/8')
    assert_equal -7, CalculationService.call('1+2*3-8/4*7')
  end

  test "invalid expression should return nil" do
    assert_nil CalculationService.call('1++2')
    assert_nil CalculationService.call('1+a')
  end

  test "cannot divide by zero" do
    assert_equal 'Cannot divide by zero', CalculationService.call('1/0')
    assert_equal 'Cannot divide by zero', CalculationService.call('5+2*3/0-1')
  end

  test "expression starting with +/- should work fine" do
    assert_equal 1, CalculationService.call('+1')
    assert_equal -2, CalculationService.call('-2')
  end

  test "supports decimal numbers" do
    assert_equal 1.234, CalculationService.call('1.234')
  end
end
