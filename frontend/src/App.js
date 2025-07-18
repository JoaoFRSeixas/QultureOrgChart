// src/App.js
import React, { useState } from 'react';
import CompaniesPage from './pages/CompaniesPage';
import EmployeesPage from './pages/EmployeesPage';
import OrgChartPage from './pages/OrgChartPage';
import './App.css';

function App() {
  const [selectedCompany, setSelectedCompany] = useState(null);
  const [selectedEmployee, setSelectedEmployee] = useState(null);

  if (!selectedCompany) {
    return <CompaniesPage onSelectCompany={setSelectedCompany} />;
  }

  if (!selectedEmployee) {
    return (
      <EmployeesPage
        company={selectedCompany}
        onBack={() => setSelectedCompany(null)}
        onSelectEmployee={setSelectedEmployee}
      />
    );
  }

  return (
    <OrgChartPage
      employee={selectedEmployee}
      onBack={() => setSelectedEmployee(null)}
    />
  );
}

export default App;
