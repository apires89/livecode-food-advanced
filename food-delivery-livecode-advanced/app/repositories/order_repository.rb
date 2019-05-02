require 'csv'
require 'byebug'

class OrderRepository
  def initialize(csv_file,meal_repository,customer_repository,employee_repository)
    @csv_file = csv_file
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def add(order)
    #set order id
    order.id = @next_id
    @orders << order
    save_csv
    @next_id += 1
  end

  def all
    @orders
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      @orders << Order.new(row)
      @next_id += 1
    end
  end

  def save_csv
    CSV.open(@csv_file, 'w') do |csv|
      csv << @orders.first.class.headers
      @orders.each do |order|
        csv << order.to_csv_row
      end
    end
  end
end
