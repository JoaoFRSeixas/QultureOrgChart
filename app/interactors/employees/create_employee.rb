require 'ostruct'

module Employees
  class CreateEmployee
    def initialize(company, params)
      @company = company
      @params = params
    end

    def call
      employee = @company.employees.new(@params)
      if employee.save
        Result.new(true, employee, :created)
      else
        Result.new(false, { errors: employee.errors.full_messages }, :unprocessable_entity)
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
