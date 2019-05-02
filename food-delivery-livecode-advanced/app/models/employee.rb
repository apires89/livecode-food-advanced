class Employee
  attr_reader :username, :password, :role
  attr_accessor :id
  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  def manager?
    @role == "manager"
  end

  def to_csv_row
    [@id, @username, @password, @role]
  end

  def self.headers
    %w(id username password role)
  end
end
