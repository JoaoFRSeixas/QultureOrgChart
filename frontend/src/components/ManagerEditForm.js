import React, { useState } from "react";

export default function ManagerEditForm({ employee, managers, onSave, onCancel }) {
  const [managerId, setManagerId] = useState(employee.manager_id || "");

  const handleSubmit = async (e) => {
    e.preventDefault();
    await onSave(managerId || null);
  };

  return (
    <form onSubmit={handleSubmit} style={{ display: "inline-block", marginLeft: 10 }}>
      <select
        value={managerId}
        onChange={e => setManagerId(e.target.value)}
        className="input-main"
        style={{ minWidth: 120 }}
      >
        <option value="">Sem gestor</option>
        {managers.map(m => (
          <option key={m.id} value={m.id}>{m.name}</option>
        ))}
      </select>
      <button className="button-main" type="submit" style={{ marginLeft: 6, padding: "7px 15px" }}>Salvar</button>
      <button type="button" className="button-main" style={{ marginLeft: 6, background: "#fff", color: "#CD90FF", border: "2px solid #CD90FF", padding: "7px 15px" }} onClick={onCancel}>
        Cancelar
      </button>
    </form>
  );
}
