require 'rails_helper'

RSpec.describe Employees::DestroyEmployee do
  let(:company) { Company.create!(name: "Org") }
  let!(:employee) { Employee.create!(company: company, name: "Ana", email: "ana@email.com") }

  it "destroys the employee" do
    expect {
      described_class.new(employee).call
    }.to change(Employee, :count).by(-1)
  end
end
