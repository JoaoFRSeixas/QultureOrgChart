class EmployeesController < ApplicationController
  before_action :set_company, only: [:index, :create]

  def index
    employees = @company.employees
    render json: employees, status: :ok
  end

  def create
    result = Employees::CreateEmployee.new(@company, employee_params).call
    render json: result.data, status: result.status
  end

  def show
    employee = Employee.find(params[:id])
    render json: employee, status: :ok
  end

  def destroy
    employee = Employee.find(params[:id])
    result = Employees::DestroyEmployee.new(employee).call
    head result.status
  end

  def update
    employee = Employee.find(params[:id])
    result = Employees::UpdateEmployee.new(employee, employee_params).call
    render json: result.data, status: result.status
  end

  def assign_manager
    employee = Employee.find(params[:id])
    manager_id = params[:manager_id]
    result = Employees::AssignManager.new(employee, manager_id).call
    render json: result.data, status: result.status
  end

  def subordinates
    employee = Employee.find(params[:id])
    result = Employees::ListSubordinates.new(employee).call
    render json: result.data, status: result.status
  end

  def second_level_subordinates
    page = params[:page] || 1
    per_page = params[:per_page] || 20

    employee = Employee.find_by(id: params[:id])
    result = Employees::ListSecondLevelSubordinates.new(employee, page: page, per_page: per_page).call

    if result.status == :ok
      render json: {
        data: ActiveModelSerializers::SerializableResource.new(result.data, each_serializer: EmployeeSerializer),
        total: result.total,
        total_pages: result.total_pages,
        current_page: result.current_page,
        per_page: result.per_page
      }, status: :ok
    else
      render json: { data: result.data }, status: result.status
    end
  end
  
  def peers
    employee = Employee.find(params[:id])
    result = Employees::ListPeers.new(employee).call
    render json: result.data, status: result.status
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :picture, :manager_id)
  end
end
