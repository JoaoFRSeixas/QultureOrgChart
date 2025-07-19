class CompaniesController < ApplicationController
  def index
    result = Companies::ListCompanies.new.call
    render json: result.data, status: result.status
  end

  def show
    result = Companies::ShowCompany.new(params[:id]).call
    render json: result.data, status: result.status
  end

  def create
    result = Companies::CreateCompany.new(company_params).call
    render json: result.data, status: result.status
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
