import React, { useEffect, useState } from 'react';
import axios from 'axios';
import OrgTree from '../components/OrgTree';
import EmployeeForm from '../components/EmployeeForm';
import ManagerEditForm from '../components/ManagerEditForm';

function EmployeesPage({ company, onBack, onSelectEmployee }) {
  const [employees, setEmployees] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showOrgChart, setShowOrgChart] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [editingManagerId, setEditingManagerId] = useState(null);

  const fetchEmployees = async () => {
    setLoading(true);
    const res = await axios.get(`http://localhost:3000/companies/${company.id}/employees`);
    setEmployees(res.data);
    setLoading(false);
  };

  useEffect(() => {
    if (!company) return;
    fetchEmployees();
    // eslint-disable-next-line
  }, [company]);

  const handleAddEmployee = async (data) => {
    await axios.post(`http://localhost:3000/companies/${company.id}/employees`, { employee: data });
    setShowForm(false);
    await fetchEmployees();
  };

  const handleDeleteEmployee = async (employee) => {
    if (window.confirm(`Tem certeza que deseja remover ${employee.name}?`)) {
      await axios.delete(`http://localhost:3000/employees/${employee.id}`);
      await fetchEmployees();
    }
  };

  const handleUpdateManager = async (employeeId, managerId) => {
    await axios.patch(`http://localhost:3000/employees/${employeeId}`, { employee: { manager_id: managerId } });
    setEditingManagerId(null);
    await fetchEmployees();
  };

  if (!company) return null;

  return (
    <div className={`card${showOrgChart ? " card--wide" : ""}`}>
      <button className="button-main" onClick={onBack}>← Voltar</button>
      <h2>Colaboradores de {company.name}</h2>
      <div className="toggle-actions-row">
        <div className="toggle-dual">
          <div
            className="toggle-slider-dual"
            style={{
              left: showOrgChart ? "50%" : 0,
              width: "50%",
              background: "#CD90FF"
            }}
          />
          <span
            className={`toggle-option-dual ${!showOrgChart ? "active" : ""}`}
            onClick={() => setShowOrgChart(false)}
          >
            Lista
          </span>
          <span
            className={`toggle-option-dual ${showOrgChart ? "active" : ""}`}
              style={{ justifyContent: 'flex-end', paddingRight: 12 }}

            onClick={() => setShowOrgChart(true)}
          >
            Organograma
          </span>
        </div>
        <button
          className="button-main outlined"
          onClick={() => setShowForm(true)}
        >
          Cadastrar colaborador
        </button>
      </div>
      {showForm && (
        <EmployeeForm
          managers={employees}
          onSave={handleAddEmployee}
          onCancel={() => setShowForm(false)}
        />
      )}
      {loading ? <div>Carregando colaboradores...</div> :
        showOrgChart ? (
          <OrgTree employees={employees} />
        ) : (
          <ul className="list">
            {employees.map(emp => (
              <li key={emp.id} className="employee-list-item">
                <div className="employee-info">
                  <span>{emp.name}</span>
                  <span className="employee-email">{emp.email}</span>
                  {editingManagerId === emp.id ? (
                    <ManagerEditForm
                      employee={emp}
                      managers={employees.filter(e => e.id !== emp.id)}
                      onSave={managerId => handleUpdateManager(emp.id, managerId)}
                      onCancel={() => setEditingManagerId(null)}
                    />
                  ) : (
                    <button
                      className="employee-org-btn"
                      style={{ marginLeft: 8, background: "#fff", color: "#CD90FF", border: "1.5px solid #CD90FF" }}
                      onClick={() => setEditingManagerId(emp.id)}
                      title="Editar gestor"
                    >
                      Editar gestor
                    </button>
                  )}
                </div>
                <button
                  className="employee-org-btn"
                  onClick={() => onSelectEmployee(emp)}
                >
                  Ver Organograma
                </button>
                <button
                  className="employee-org-btn"
                  style={{ background: "#fff", color: "#CD90FF", border: "1.5px solid #CD90FF", marginLeft: 10 }}
                  onClick={() => handleDeleteEmployee(emp)}
                  title="Remover colaborador"
                >
                  Remover
                </button>
              </li>
            ))}
          </ul>
        )
      }
    </div>
  );
}

export default EmployeesPage;
