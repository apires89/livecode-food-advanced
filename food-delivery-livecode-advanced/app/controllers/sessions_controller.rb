require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def login
    #ask for user name
    username = @view.ask_for(:username)
    #ask for password
    password = @view.ask_for(:password)
    #check if password check out
    employee = @employee_repository.find_by_username(username)
    if employee && employee.password == password
      employee
    else
      @view.wrong_credentials
      login #recursive
    end
  end


  #

end
