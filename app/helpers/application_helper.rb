# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def cycle(first_value, *values)
    values.unshift(first_value)
    return Cycle.new(*values)
  end

  class Cycle
    def initialize(first_value, *values)
      @values = values.unshift(first_value)
      @index = 0
    end

    def to_s
      value = @values[@index].to_s
      @index = (@index + 1) % @values.size
      return value
    end
  end

  
end
