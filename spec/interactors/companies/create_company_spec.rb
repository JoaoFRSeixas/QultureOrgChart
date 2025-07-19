require 'rails_helper'

RSpec.describe Companies::CreateCompany do
  it "creates a company with valid params" do
    interactor = described_class.new(name: "Qulture")
    result = interactor.call

    expect(result.status).to eq(:created)
    expect(result.data).to be_a(Company)
    expect(result.data.name).to eq("Qulture")
  end

  it "returns errors with invalid params" do
    interactor = described_class.new(name: "")
    result = interactor.call

    expect(result.status).to eq(:unprocessable_entity)
    expect(result.data[:errors]).to include("Name can't be blank")
  end
end
