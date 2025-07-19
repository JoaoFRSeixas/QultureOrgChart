require 'ostruct'

module Companies
  class CreateCompany
    def initialize(params)
      @params = params
    end

    def call
      company = Company.new(@params)
      if company.save
        OpenStruct.new(data: company, status: :created)
      else
        OpenStruct.new(data: { errors: company.errors.full_messages }, status: :unprocessable_entity)
      end
    end
  end
end
