require 'rails_helper'

RSpec.describe Employees::ListSubordinates do
  let(:company) { Company.create!(name: "Org") }
  let!(:manager) { Employee.create!(company: company, name: "Boss", email: "boss@email.com") }
  let!(:employee) { Employee.create!(company: company, name: "Ana", email: "ana@email.com", manager: manager) }

  it "returns direct subordinates" do
    result = described_class.new(manager).call
    expect(result.status).to eq(:ok)
    expect(result.data).to include(employee)
  end
end
