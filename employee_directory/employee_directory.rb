require_relative '../employee'

module EmployeeDirectory

  module_function
  def search(employee_reference)
    if employee_reference =~ /^\d*$/
      [Employee.get(employee_reference)]
    else
      Employee.all(:name.like => "%#{employee_reference}%")
    end
  end

end
