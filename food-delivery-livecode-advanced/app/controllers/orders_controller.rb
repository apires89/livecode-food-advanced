require_relative '../models/order'
require_relative '../views/orders_view'
require 'byebug'
class OrdersController
  # User actions?

  def initialize(order_repository,meal_repository,employee_repository,customer_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @view = OrdersView.new
  end

  def add
    #display meals
    @view.display_meals(@meal_repository.all)
    #ask for meal id
    my_meal_id = @view.ask_for(:meal_id).to_i
    #find in repo
    meal = @meal_repository.find(my_meal_id)
    #display customers
    @view.display_customers(@customer_repository.all)

    #ask for customer id
    customer = @customer_repository.find(@view.ask_for(:customer_id).to_i)
    #display employees
    @view.display_employees(@employee_repository.all)
    #ask for employee id
    employee = @employee_repository.find(@view.ask_for(:employee_id).to_i)
    #create order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    #send it to repo
    @order_repository.add(order)
  end

  def list_undelivered
    orders = @order_repository.all
    orders.select {|order| order.delivered? == false }


  end
end
