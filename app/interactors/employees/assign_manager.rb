require 'ostruct'

module Employees
  class AssignManager
    def initialize(employee, manager_id)
      @employee = employee
      @manager_id = manager_id
    end

    def call
      manager = Employee.find_by(id: @manager_id)
      return Result.new(false, { error: "Manager not found" }, :not_found) unless manager

      if @employee.company_id != manager.company_id
        return Result.new(false, { error: "Manager must belong to the same company" }, :unprocessable_entity)
      end

      if creates_loop?(@employee, manager)
        return Result.new(false, { error: "This association would create a loop in the hierarchy" }, :unprocessable_entity)
      end

      @employee.manager = manager
      if @employee.save
        Result.new(true, @employee, :ok)
      else
        Result.new(false, { errors: @employee.errors.full_messages }, :unprocessable_entity)
      end
    end

    private

    def creates_loop?(employee, potential_manager)
      current = potential_manager
      while current
        return true if current == employee
        current = current.manager
      end
      false
    end

    class Result
      attr_reader :success, :data, :status
      def initialize(success, data, status)
        @success = success
        @data = data
        @status = status
      end
      def success?; @success; end
    end
  end
end
