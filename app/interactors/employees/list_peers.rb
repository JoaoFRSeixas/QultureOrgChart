module Employees
  class ListPeers
    def initialize(employee)
      @employee = employee
    end

    def call
      if @employee.manager
        peers = @employee.manager.subordinates.where.not(id: @employee.id)
        Result.new(true, peers, :ok)
      else
        Result.new(true, [], :ok)
      end
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
