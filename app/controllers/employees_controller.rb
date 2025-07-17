class EmployeesController < ApplicationController
  before_action :set_company, only: [:index, :create]

  def index
    employees = @company.employees
    render json: employees, status: :ok
  end

  def create
    employee = @company.employees.new(employee_params)
    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    employee = Employee.find(params[:id])
    render json: employee, status: :ok
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    head :no_content
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :picture, :manager_id)
  end
end
