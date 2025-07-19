require 'rails_helper'

RSpec.describe Employees::ListSecondLevelSubordinates do
  let(:company) { Company.create!(name: "Org") }
  let!(:manager) { Employee.create!(company: company, name: "Boss", email: "boss@email.com") }
  let!(:mid) { Employee.create!(company: company, name: "Mid", email: "mid@email.com", manager: manager) }
  let!(:junior) { Employee.create!(company: company, name: "Junior", email: "junior@email.com", manager: mid) }

  it "returns subordinates of subordinates" do
    result = described_class.new(manager).call
    expect(result.status).to eq(:ok)
    expect(result.data).to include(junior)
    expect(result.data).not_to include(mid)
  end
end
