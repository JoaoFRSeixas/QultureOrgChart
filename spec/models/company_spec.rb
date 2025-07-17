require 'rails_helper'

RSpec.describe "Companies API", type: :request do
  describe "GET /companies" do
    it "returns all companies" do
      create_list(:company, 3)
      get "/companies"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /companies" do
    it "creates a company" do
      post "/companies", params: { company: { name: "Qulture" } }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("Qulture")
    end
  end
end
