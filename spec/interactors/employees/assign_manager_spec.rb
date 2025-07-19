require 'rails_helper'

RSpec.describe Employees::AssignManager do
  let(:company) { Company.create!(name: "Org") }
  let!(:manager) { Employee.create!(company: company, name: "Boss", email: "boss@email.com") }
  let!(:employee) { Employee.create!(company: company, name: "Ana", email: "ana@email.com") }

  it "assigns a manager" do
    result = described_class.new(employee, manager.id).call
    expect(result.status).to eq(:ok)
    expect(result.data.manager_id).to eq(manager.id)
  end

  it "prevents loops in hierarchy" do
    employee.update(manager: manager)
    result = described_class.new(manager, employee.id).call
    expect(result.status).to eq(:unprocessable_entity)
    expect(result.data[:error]).to match(/loop/i)
  end

  it "prevents manager from another company" do
    other_company = Company.create!(name: "Other")
    outside_manager = Employee.create!(company: other_company, name: "OtherBoss", email: "o@email.com")
    result = described_class.new(employee, outside_manager.id).call
    expect(result.status).to eq(:unprocessable_entity)
    expect(result.data[:error]).to match(/same company/i)
  end
end
