require 'rails_helper'

RSpec.describe Companies::ListCompanies do
  it "returns all companies" do
    company1 = Company.create!(name: "C1")
    company2 = Company.create!(name: "C2")

    result = described_class.new.call

    expect(result.status).to eq(:ok)
    expect(result.data).to include(company1, company2)
  end
end
