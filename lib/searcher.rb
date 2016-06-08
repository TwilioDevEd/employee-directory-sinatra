class Searcher
  def search(employee_reference)
    if employee_reference =~ /^\d*$/
      [Employee.get(employee_reference)]
    else
      Employee.all(:name.like => "%#{employee_reference}%")
    end
  end
end
