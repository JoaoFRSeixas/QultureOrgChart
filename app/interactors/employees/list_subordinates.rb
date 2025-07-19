module Employees
  class ListSubordinates
    def initialize(employee)
      @employee = employee
    end

    def call
      Result.new(true, @employee.subordinates, :ok)
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
