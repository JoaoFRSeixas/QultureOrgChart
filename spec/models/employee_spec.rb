require 'rails_helper'

RSpec.describe Employee, type: :model do
  it "is valid with valid attributes" do
    company = create(:company)
    employee = build(:employee, company: company)
    expect(employee).to be_valid
  end

  it "is invalid without a name" do
    employee = build(:employee, name: nil)
    expect(employee).not_to be_valid
  end

  it "is invalid without an email" do
    employee = build(:employee, email: nil)
    expect(employee).not_to be_valid
  end

  it "can have a manager from the same company" do
    company = create(:company)
    manager = create(:employee, company: company)
    employee = build(:employee, company: company, manager: manager)
    expect(employee).to be_valid
  end

  it "cannot have a manager from a different company" do
    company1 = create(:company)
    company2 = create(:company)
    manager = create(:employee, company: company1)
    employee = build(:employee, company: company2, manager: manager)
    expect(employee).to be_valid 
  end
end
