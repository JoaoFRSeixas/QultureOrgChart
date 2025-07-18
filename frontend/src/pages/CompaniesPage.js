import React, { useState, useEffect } from "react";
import axios from "axios";
import CompanyForm from "../components/CompanyForm";

function CompaniesPage({ onSelectCompany }) {
  const [companies, setCompanies] = useState([]);
  const [showForm, setShowForm] = useState(false);
  const [loading, setLoading] = useState(true);

  const fetchCompanies = async () => {
    setLoading(true);
    const res = await axios.get('http://localhost:3000/companies');
    setCompanies(res.data);
    setLoading(false);
  };

  useEffect(() => {
    fetchCompanies();
  }, []);

  const handleAddCompany = async (data) => {
    await axios.post('http://localhost:3000/companies', { company: data });
    setShowForm(false);
    await fetchCompanies();
  };

  return (
    <div className="card">
      <h2>Empresas</h2>
      <button className="button-main" onClick={() => setShowForm(true)}>Cadastrar empresa</button>
      {showForm && (
        <CompanyForm onSave={handleAddCompany} onCancel={() => setShowForm(false)} />
      )}
      {loading ? (
        <div style={{ textAlign: 'center', margin: 30 }}>Carregando empresas...</div>
      ) : (
        <ul className="list">
          {companies.map(company => (
            <li className="company-list-item" key={company.id}>
              <button className="company-list-button" onClick={() => onSelectCompany(company)}>
                {company.name}
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default CompaniesPage;
