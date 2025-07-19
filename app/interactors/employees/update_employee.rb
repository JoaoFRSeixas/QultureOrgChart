module Employees
  class UpdateEmployee
    def initialize(employee, params)
      @employee = employee
      @params = params
    end

    def call
      new_manager_id = @params[:manager_id]
      manager = Employee.find_by(id: new_manager_id) if new_manager_id.present?

      if manager && @employee.company_id != manager.company_id
        return Result.new(false, { error: "Manager must belong to the same company" }, :unprocessable_entity)
      end

      if manager && creates_loop?(@employee, manager)
        return Result.new(false, { error: "This association would create a loop in the hierarchy" }, :unprocessable_entity)
      end

      if @employee.update(@params)
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
