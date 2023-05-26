class EmployeeTicketsController < ApplicationController
  def create
    emptk = EmployeeTicket.create!(employee_id: params[:id], ticket_id: params[:ticket_id])
    employee = Employee.find_by(id: emptk.employee_id)
    redirect_to "/employees/#{employee.id}"
  end
end

