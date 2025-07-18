import React, { useEffect, useState } from 'react';
import axios from 'axios';

function OrgChartPage({ employee, onBack }) {
  const [manager, setManager] = useState(null);
  const [peers, setPeers] = useState([]);
  const [subordinates, setSubordinates] = useState([]);
  const [secondLevel, setSecondLevel] = useState([]);
  const [loading, setLoading] = useState(true);

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
      axios.get(`http://localhost:3000/employees/${employee.id}/subordinates`),
      axios.get(`http://localhost:3000/employees/${employee.id}/second_level_subordinates`)
    ]).then(([peersRes, subsRes, secLevelRes]) => {
      setPeers(peersRes.data);
      setSubordinates(subsRes.data);
      setSecondLevel(secLevelRes.data);
    }).finally(() => setLoading(false));
  }, [employee]);

  if (!employee) return null;
  if (loading) return <div className="card"><h2>Carregando organograma...</h2></div>;

  return (
    <div className="card">
      <button className="button-main" onClick={onBack}>← Voltar</button>
      <h2>Organograma de {employee.name}</h2>
      <div style={{marginBottom: 18}}>
        <strong>Gestor:</strong> {manager ? manager.name : <i>Nenhum gestor</i>}
      </div>
      <div style={{marginBottom: 12}}>
        <strong>Pares:</strong>
        {peers.length === 0 ? <i> Nenhum</i> :
          <ul className="list">{peers.map(p => <li key={p.id}>{p.name}</li>)}</ul>}
      </div>
      <div style={{marginBottom: 12}}>
        <strong>Liderados diretos:</strong>
        {subordinates.length === 0 ? <i> Nenhum</i> :
          <ul className="list">{subordinates.map(s => <li key={s.id}>{s.name}</li>)}</ul>}
      </div>
      <div>
        <strong>Liderados 2º nível:</strong>
        {secondLevel.length === 0 ? <i> Nenhum</i> :
          <ul className="list">{secondLevel.map(s2 => <li key={s2.id}>{s2.name}</li>)}</ul>}
      </div>
    </div>
  );
}

export default OrgChartPage;
