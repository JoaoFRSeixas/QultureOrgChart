require 'rails_helper'

RSpec.describe Employees::ListPeers do
  let(:company) { Company.create!(name: "Org") }
  let!(:manager) { Employee.create!(company: company, name: "Boss", email: "boss@email.com") }
  let!(:employee1) { Employee.create!(company: company, name: "Ana", email: "ana@email.com", manager: manager) }
  let!(:employee2) { Employee.create!(company: company, name: "Beto", email: "beto@email.com", manager: manager) }

  it "returns peers (other subordinates of the same manager)" do
    result = described_class.new(employee1).call
    expect(result.status).to eq(:ok)
    expect(result.data).to include(employee2)
    expect(result.data).not_to include(employee1)
  end
end
