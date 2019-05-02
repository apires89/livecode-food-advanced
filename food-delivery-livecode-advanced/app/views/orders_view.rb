class OrdersView
  def ask_for(label)
    puts "#{label}?"
    print '> '
    gets.chomp
  end

  def display_meals(meals)
    meals.each do |meal|
      puts "#{meal.id} - #{meal.name}, #{meal.price}€"
    end
  end

  def display_employees(employees)
    employees.each do |employee|
      puts "#{employee.id} - #{employee.username}, #{employee.role}"
    end
  end

  def display_customers(customers)
    customers.each do |customer|
      puts "#{customer.id} - #{customer.name}, #{customer.address}"
    end
  end


end
