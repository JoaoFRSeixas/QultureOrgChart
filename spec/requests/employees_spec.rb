require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let!(:company) { create(:company) }
  let!(:manager) { create(:employee, company: company) }
  let!(:employee) { create(:employee, company: company, manager: manager) }
  let(:employee_id) { employee.id }

  describe "GET /companies/:company_id/employees" do
    it "returns all employees of a company" do
      get company_employees_path(company_id: company.id), as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to be >= 2
    end
  end

  describe "POST /companies/:company_id/employees" do
    context "with valid params" do
      let(:params) do
        {
          employee: {
            name: "Novo Colaborador",
            email: "novo@teste.com",
            picture: "https://exemplo.com/img.png",
            manager_id: manager.id
          }
        }
      end

      it "creates an employee" do
        expect {
          post company_employees_path(company_id: company.id), params: params, as: :json
        }.to change(Employee, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["name"]).to eq("Novo Colaborador")
      end
    end

    context "with invalid params" do
      let(:params) do
        { employee: { name: "", email: "" } }
      end

      it "does not create employee" do
        expect {
          post company_employees_path(company_id: company.id), params: params, as: :json
        }.not_to change(Employee, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /employees/:id" do
    it "shows the employee" do
      get employee_path(employee_id), as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(employee_id)
    end
  end

  describe "PATCH /employees/:id" do
    it "updates the manager" do
      new_manager = create(:employee, company: company)
      patch employee_path(employee_id), params: { employee: { manager_id: new_manager.id } }, as: :json
      expect(response).to have_http_status(:ok)
      expect(Employee.find(employee_id).manager_id).to eq(new_manager.id)
    end

    it "prevents loop in management" do
      patch employee_path(manager.id), params: { employee: { manager_id: employee.id } }, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /employees/:id" do
    it "removes the employee" do
      target = create(:employee, company: company)
      expect {
        delete employee_path(target.id), as: :json
      }.to change(Employee, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "manager validation" do
    it "does not allow manager from another company" do
      other_company = create(:company)
      outsider = create(:employee, company: other_company)
      patch employee_path(employee.id), params: { employee: { manager_id: outsider.id } }, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
