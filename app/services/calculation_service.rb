class CalculationService < ApplicationService
  def initialize(expression)
    @expression = expression
  end

  def call
    stack = []
    number = nil
    decimal_base = nil

    @expression.chars.each do |char|
      case char
      when '0'..'9'
        number ||= 0
        if decimal_base.nil?
          number = number * 10 + char.ord - '0'.ord
        else
          number += (char.ord - '0'.ord) / decimal_base
          decimal_base *= 10
        end
      when '.'
        decimal_base = 10.0
      when '+', '-', '*', '/'
        if stack.empty?
          stack << (number || 0)
        else
          return nil if number.nil?

          if precedence(stack.last) < precedence(char)
            stack << number
          else
            op = stack.pop
            left = stack.pop
            stack << operation(left, op, number)
          end
        end
        number = nil
        decimal_base = nil
        stack << char
      else
        return nil
      end
    end

    stack << number unless number.nil?
    return 0 if stack.empty?

    loop do
      right = stack.pop
      return nil if right.is_a?(String)

      op = stack.pop
      return right if op.nil?

      left = stack.pop
      stack << operation(left, op, right)
      break if stack.size == 1
    end

    stack.pop

  rescue ZeroDivisionError
    'Cannot divide by zero'
  end

  private

  def precedence(operator)
    case operator
    when '+', '-' then 1
    when '*', '/' then 2
    else 0
    end
  end

  def operation(left, op, right)
    case op
    when '+' then left + right
    when '-' then left - right
    when '*' then left * right
    when '/'
      raise ZeroDivisionError if right.zero?
      left.to_f / right
    else nil
    end
  end
end
