require 'rails_helper'

RSpec.describe "Companies API", type: :request do
  let!(:companies) { create_list(:company, 3) }
  let(:company_id) { companies.first.id }

  describe "GET /companies" do
    it "returns all companies" do
      get companies_path, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /companies/:id" do
    it "returns the company" do
      get company_path(company_id), as: :json
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(company_id)
      expect(json["name"]).to eq(companies.first.name)
    end
  end

  describe "POST /companies" do
    context "with valid params" do
      let(:valid_params) { { company: { name: "Nova Empresa" } } }

      it "creates a new company" do
        expect {
          post companies_path, params: valid_params, as: :json
        }.to change(Company, :count).by(1)
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["name"]).to eq("Nova Empresa")
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { company: { name: "" } } }

      it "does not create a company" do
        expect {
          post companies_path, params: invalid_params, as: :json
        }.not_to change(Company, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

end
