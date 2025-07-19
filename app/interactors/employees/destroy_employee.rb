module Employees
  class DestroyEmployee
    def initialize(employee)
      @employee = employee
    end

    def call
      @employee.destroy
      Result.new(true, nil, :no_content)
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
