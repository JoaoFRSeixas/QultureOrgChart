require 'ostruct'

module Companies
  class ListCompanies
    def call
      companies = Company.all
      OpenStruct.new(data: companies, status: :ok)
    end
  end
end
