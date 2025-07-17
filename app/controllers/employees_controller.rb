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

  def update
    employee = Employee.find(params[:id])
    if employee.update(employee_params)
      render json: employee, status: :ok
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def assign_manager
    employee = Employee.find(params[:id])
    manager = Employee.find_by(id: params[:manager_id])

    unless manager
      return render json: { error: "Manager not found" }, status: :not_found
    end

    if employee.company_id != manager.company_id
      return render json: { error: "Manager must belong to the same company" }, status: :unprocessable_entity
    end

    if creates_loop?(employee, manager)
      return render json: { error: "This association would create a loop in the hierarchy" }, status: :unprocessable_entity
    end

    employee.manager = manager
    if employee.save
      render json: employee, status: :ok
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def subordinates
    employee = Employee.find(params[:id])
    render json: employee.subordinates, status: :ok
  end

  def second_level_subordinates
    employee = Employee.find(params[:id])
    second_level = employee.subordinates.flat_map(&:subordinates)
    render json: second_level, status: :ok
  end

  def peers
    employee = Employee.find(params[:id])
    if employee.manager
      peers = employee.manager.subordinates.where.not(id: employee.id)
      render json: peers, status: :ok
    else
      render json: [], status: :ok
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :picture, :manager_id)
  end

  def creates_loop?(employee, potential_manager)
    current = potential_manager
    while current
      return true if current == employee
      current = current.manager
    end
    false
  end

end
