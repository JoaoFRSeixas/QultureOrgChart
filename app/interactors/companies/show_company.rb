require 'ostruct'

module Companies
  class ShowCompany
    def initialize(id)
      @id = id
    end

    def call
      company = Company.find(@id)
      OpenStruct.new(data: company, status: :ok)
    rescue ActiveRecord::RecordNotFound
      OpenStruct.new(data: { error: "Company not found" }, status: :not_found)
    end
  end
end
