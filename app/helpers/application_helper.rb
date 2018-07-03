require "calculator"

module ApplicationHelper

  def calculate_result
    # Calculator.calculate(params[:expression])
    Calculator.another_calculator params[:expression]
  end
end
