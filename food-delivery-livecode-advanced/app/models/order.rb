require 'byebug'
class Order
  attr_reader :meal, :customer, :employee
  attr_accessor :id, :delivered
  def initialize(attributes = {})
    @id = attributes[:id]
    @meal = attributes[:meal]
    @employee = attributes[:employee]
    @customer = attributes[:customer]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def mark_as_delivered!
    @delivered = true
  end

  def to_csv_row
    [@id, @delivered, @meal.id, @employee.id, @customer.id]
  end

  def self.headers
    %w(id, delivered, meal_id, employee_id, customer_id)
  end


end
