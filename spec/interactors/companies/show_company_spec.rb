require 'rails_helper'

RSpec.describe Companies::ShowCompany do
  it "returns the company when found" do
    company = Company.create!(name: "Showme")

    result = described_class.new(company.id).call

    expect(result.status).to eq(:ok)
    expect(result.data).to eq(company)
  end

  it "returns not_found if company does not exist" do
    result = described_class.new(99999).call

    expect(result.status).to eq(:not_found)
    expect(result.data[:error]).to eq("Company not found")
  end
end
