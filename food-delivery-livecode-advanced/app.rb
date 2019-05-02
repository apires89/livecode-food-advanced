# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb

# require_relative 'app/repositories/customer_repository'
# require_relative 'app/controllers/customers_controller'
# require_relative 'app/repositories/meal_repository'
# require_relative 'app/controllers/meals_controller'
# require_relative 'router'

# customers_csv = 'data/customers.csv'
# customer_repository = CustomerRepository.new(customers_csv)
# customers_controller = CustomersController.new(customer_repository)

# meals_csv = 'data/meals.csv'
# meal_repository = MealRepository.new(meals_csv)
# meals_controller = MealsController.new(meal_repository)

# router = Router.new(meals_controller, customers_controller)
# router.run

require_relative "app/repositories/meal_repository"
require_relative "app/controllers/meals_controller"
require_relative "app/repositories/employee_repository"
require_relative "app/controllers/sessions_controller"
require_relative "app/controllers/customers_controller"
require_relative "app/repositories/customer_repository"
require_relative "app/controllers/orders_controller"
require_relative "app/repositories/order_repository"
require_relative "router"


MEALS_CSV_FILE = File.join(__dir__, "data/meals.csv")
EMPLOYEES_CSV_FILE = File.join(__dir__, "data/employees.csv")
CUSTOMERS_CSV_FILE = File.join(__dir__, "data/customers.csv")
ORDERS_CSV_FILE = File.join(__dir__, "data/orders.csv")

meal_repo = MealRepository.new(MEALS_CSV_FILE)
meals_controller = MealsController.new(meal_repo)

employee_repo = EmployeeRepository.new(EMPLOYEES_CSV_FILE)
sessions_controller = SessionsController.new(employee_repo)

customer_repo = CustomerRepository.new(CUSTOMERS_CSV_FILE)
customers_controller = CustomersController.new(customer_repo)

order_repo = OrderRepository.new(ORDERS_CSV_FILE, meal_repo, employee_repo, customer_repo)
orders_controller = OrdersController.new(order_repo, meal_repo, employee_repo, customer_repo)

router = Router.new(meals_controller, customers_controller, orders_controller, sessions_controller)
router.run
