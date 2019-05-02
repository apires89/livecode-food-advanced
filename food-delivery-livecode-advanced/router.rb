class Router
  def initialize(meals_controller, customers_controller, orders_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @orders_controller = orders_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
          print_manager_menu
          choice = gets.chomp.to_i
          print `clear`
          manager_action(choice)
        else
          print_delivery_guy_menu
          choice = gets.chomp.to_i
          print `clear`
          delivery_guy_action(choice)
        end
      end
    end
  end

  private

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all meals"
    puts "2. Add new meal"
    puts "3. List all customers"
    puts "4. Add new customer"
    puts "5. List undelivered orders"
    puts "6. Add an order"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def print_delivery_guy_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List my undelivered orders"
    puts "2. Mark order as delivered"
    puts "3. Logout"
    puts "4. Exit"
    print "> "
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add_meal
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add_customer
    when 5 then @orders_controller.list_undelivered
    when 6 then @orders_controller.add
    when 7 then logout!
    when 8 then stop!
    else
      puts "Try again..."
    end
  end

  def delivery_guy_action(choice)
    case choice
    when 1 then @orders_controller.list_my_undelivered(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 3 then logout!
    when 4 then stop!
    else
      puts "Try again..."
    end
  end

  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end
end
