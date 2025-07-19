require 'rails_helper'

RSpec.describe Employees::UpdateEmployee do
  let(:company) { Company.create!(name: "Org") }
  let(:employee) { Employee.create!(company: company, name: "Ana", email: "ana@email.com") }

  it "updates employee attributes" do
    result = described_class.new(employee, name: "Ana Paula").call
    expect(result.status).to eq(:ok)
    expect(result.data.name).to eq("Ana Paula")
  end

  it "returns errors for invalid update" do
    result = described_class.new(employee, name: "").call
    expect(result.status).to eq(:unprocessable_entity)
    expect(result.data[:errors]).to include("Name can't be blank")
  end
end
