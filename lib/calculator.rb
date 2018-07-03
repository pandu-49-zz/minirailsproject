class Calculator
  def self.calculate(expression = nil)
    return "No Input" if !expression.present?

    while match = /(\d+(?:\.\d+)?)\s*(\*|\/)\s*(\d+(?:\.\d+)?)/.match(expression)
      substring, a, operator, b = match.to_a
      case operator
      when '*' then number = a.to_f * b.to_f
      when '/' then number = a.to_f / b.to_f
      end
      number = number.to_i if number % 1 == 0
      expression.sub!(substring, number.to_s)
    end

    while match = /(\d+(?:\.\d+)?)\s*(\+|-)\s*(\d+(?:\.\d+)?)/.match(expression)
      substring, a, operator, b = match.to_a
      case operator
      when '+' then number = a.to_f + b.to_f
      when '-' then number = a.to_f - b.to_f
      end
      number = number.to_i if number % 1 == 0
      expression.sub!(substring, number.to_s)
    end

    if /^-?\d+$/ =~ expression
      return expression.to_i
    elsif /^-?\d+\.\d+$/ =~ expression
      return expression.to_f.round(2)
    else
      return "Invalid input"
    end
  end

  def self.another_calculator(expression = nil)
    expression.strip!
    return "No Input" if !expression.present?

    # if expression != /(\d+(?:\.\d+)?)\s*(\+|-|\*|\/)\s*(\d+(?:\.\d+)?)*/.match(expression).to_s
    #   sample
    #   return "Invalid Input"
    # end

    numbers = expression.split(/[+|\/|*|-]/).reject{ |c| c.empty? }.map { |e| e.to_f }
    operators = expression.split(/\d+/).reject{ |c| c.empty? }

    #performing multiplications and divisions
    operators.each_with_index do |operator, index|
      case operator
      when "*" then value = numbers[index] * numbers[index+1]
      when "/" then value = numbers[index] / numbers[index+1]
      end
      numbers[index] = value
      numbers.delete_at(index+1)
      operators.delete_at(index)
    end

    #Performing addition and subtraction operations
    operators.each_with_index do |operator, index|
      case operator
      when "+" then value = numbers[index] + numbers[index+1]
      when "-" then value = numbers[index] - numbers[index+1]
      end
      numbers[index] = value
      numbers.delete_at(index+1)
      operators.delete(index)
    end

    return numbers.first
  end
end
