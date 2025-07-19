require 'rails_helper'

RSpec.describe Employees::CreateEmployee do
  let(:company) { Company.create!(name: "Org") }

  it "creates an employee with valid params" do
    result = described_class.new(company, name: "Ana", email: "ana@email.com").call
    expect(result.status).to eq(:created)
    expect(result.data).to be_a(Employee)
    expect(result.data.name).to eq("Ana")
  end

  it "returns errors for invalid params" do
    result = described_class.new(company, name: "").call
    expect(result.status).to eq(:unprocessable_entity)
    expect(result.data[:errors]).to include("Name can't be blank")
  end
end
