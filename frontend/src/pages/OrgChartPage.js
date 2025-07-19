import React, { useEffect, useState } from 'react';
import axios from 'axios';

function OrgChartPage({ employee, onBack }) {
  const [manager, setManager] = useState(null);
  const [peers, setPeers] = useState([]);
  const [subordinates, setSubordinates] = useState([]);
  const [secondLevel, setSecondLevel] = useState([]);
  const [secondLevelMeta, setSecondLevelMeta] = useState({});
  const [secondLevelPage, setSecondLevelPage] = useState(1);
  const [loading, setLoading] = useState(true);

  const fetchSecondLevel = async (page = 1) => {
    const res = await axios.get(
      `http://localhost:3000/employees/${employee.id}/second_level_subordinates?page=${page}`
    );
    setSecondLevel(res.data.data || []);
    setSecondLevelMeta(
      res.data.meta || {
        total_pages: res.data.total_pages,
        current_page: res.data.current_page,
        total: res.data.total,
        per_page: res.data.per_page,
      }
    );
  };

  useEffect(() => {
    if (!employee) return;
    setLoading(true);

    if (employee.manager_id) {
      axios.get(`http://localhost:3000/employees/${employee.manager_id}`)
        .then(res => setManager(res.data));
    } else {
      setManager(null);
    }

    Promise.all([
      axios.get(`http://localhost:3000/employees/${employee.id}/peers`),
      axios.get(`http://localhost:3000/employees/${employee.id}/subordinates`)
    ]).then(([peersRes, subsRes]) => {
      setPeers(peersRes.data);
      setSubordinates(subsRes.data);
    }).finally(() => setLoading(false));

    fetchSecondLevel(1);
    setSecondLevelPage(1);
    // eslint-disable-next-line
  }, [employee]);

  useEffect(() => {
    if (employee) fetchSecondLevel(secondLevelPage);
    // eslint-disable-next-line
  }, [secondLevelPage]);

  if (!employee) return null;
  if (loading) return (
    <div className="card">
      <h2>Carregando organograma...</h2>
    </div>
  );

  return (
    <div className="card">
      <button className="button-main" onClick={onBack} style={{ marginBottom: 16 }}>← Voltar</button>
      <h2 style={{ marginBottom: 28 }}>Organograma de {employee.name}</h2>

      <div className="org-block">
        <span className="org-label">Gestor:</span>
        {manager ? (
          <span className="org-value">{manager.name} <span className="employee-email">({manager.email})</span></span>
        ) : (
          <i className="org-value">Nenhum gestor</i>
        )}
      </div>

      <div className="org-block">
        <span className="org-label">Pares:</span>
        {peers.length === 0 ? (
          <i className="org-value">Nenhum</i>
        ) : (
          <ul className="list org-list">
            {peers.map(p => (
              <li key={p.id} className="org-item">
                <span>{p.name}</span>
                <span className="employee-email">({p.email})</span>
              </li>
            ))}
          </ul>
        )}
      </div>

      <div className="org-block">
        <span className="org-label">Liderados diretos:</span>
        {subordinates.length === 0 ? (
          <i className="org-value">Nenhum</i>
        ) : (
          <ul className="list org-list">
            {subordinates.map(s => (
              <li key={s.id} className="org-item">
                <span>{s.name}</span>
                <span className="employee-email">({s.email})</span>
              </li>
            ))}
          </ul>
        )}
      </div>

      <div className="org-block">
        <span className="org-label">Liderados 2º nível:</span>
        {secondLevel.length === 0 ? (
          <i className="org-value">Nenhum</i>
        ) : (
          <>
            <ul className="list org-list">
              {secondLevel.map(s2 => (
                <li key={s2.id} className="org-item">
                  <span>{s2.name}</span>
                  <span className="employee-email">({s2.email})</span>
                </li>
              ))}
            </ul>
            {secondLevelMeta.total_pages > 1 && (
              <div className="org-pagination">
                <button
                  className="employee-org-btn"
                  onClick={() => setSecondLevelPage(secondLevelPage - 1)}
                  disabled={secondLevelPage <= 1}
                  style={{ marginRight: 8 }}
                >
                  ← Anterior
                </button>
                <span style={{ fontWeight: 600, color: "#7648ab" }}>
                  Página {secondLevelMeta.current_page || secondLevelPage} de {secondLevelMeta.total_pages}
                </span>
                <button
                  className="employee-org-btn"
                  onClick={() => setSecondLevelPage(secondLevelPage + 1)}
                  disabled={secondLevelPage >= secondLevelMeta.total_pages}
                  style={{ marginLeft: 8 }}
                >
                  Próxima →
                </button>
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
}

export default OrgChartPage;
