require 'rails_helper'

RSpec.describe Employees::ListSecondLevelSubordinates do
  let(:company) { Company.create!(name: "Org") }
  let!(:manager) { Employee.create!(company: company, name: "Boss", email: "boss@email.com") }

  before do
    10.times do |i|
      mid = Employee.create!(company: company, name: "Mid#{i}", email: "mid#{i}@email.com", manager: manager)
      10.times do |j|
        Employee.create!(company: company, name: "Junior#{i}_#{j}", email: "junior#{i}_#{j}@email.com", manager: mid)
      end
    end
  end

  it "returns paginated second level subordinates" do
    result = described_class.new(manager, page: 2, per_page: 15).call
    expect(result.status).to eq(:ok)
    expect(result.data.length).to eq(15)
    expect(result.total).to eq(100)
    expect(result.current_page).to eq(2)
    expect(result.total_pages).to eq(7)
  end

  it "returns all on last page if less than per_page" do
    result = described_class.new(manager, page: 7, per_page: 15).call
    expect(result.status).to eq(:ok)
    expect(result.data.length).to eq(10)
  end

  it "returns not found if employee missing" do
    result = described_class.new(nil).call
    expect(result.status).to eq(:not_found)
    expect(result.data[:error]).to eq("Employee not found")
  end
end
