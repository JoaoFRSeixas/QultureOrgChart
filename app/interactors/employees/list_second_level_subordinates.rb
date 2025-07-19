require 'ostruct'

module Employees
  class ListSecondLevelSubordinates
    def initialize(employee, page: 1, per_page: 20)
      @employee = employee
      @page = page.to_i
      @per_page = per_page.to_i
    end

    def call
      return OpenStruct.new(data: { error: "Employee not found" }, status: :not_found) unless @employee

      first_level = @employee.subordinates
      second_level = Employee.where(manager_id: first_level.select(:id))
      total = second_level.count

      paginated = second_level.offset((@page - 1) * @per_page).limit(@per_page)

      OpenStruct.new(
        data: paginated,
        status: :ok,
        total: total,
        total_pages: (total.to_f / @per_page).ceil,
        current_page: @page,
        per_page: @per_page
      )
    end
  end
end
