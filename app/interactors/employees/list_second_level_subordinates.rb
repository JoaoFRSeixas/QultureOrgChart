module Employees
  class ListSecondLevelSubordinates
    def initialize(employee)
      @employee = employee
    end

    def call
      second_level = @employee.subordinates.flat_map(&:subordinates)
      Result.new(true, second_level, :ok)
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
