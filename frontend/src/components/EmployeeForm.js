import React, { useState } from "react";

export default function EmployeeForm({ managers, onSave, onCancel }) {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [picture, setPicture] = useState("");
  const [managerId, setManagerId] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    await onSave({
      name,
      email,
      picture,
      manager_id: managerId || null,
    });
    setName("");
    setEmail("");
    setPicture("");
    setManagerId("");
    setLoading(false);
  };

  return (
    <form className="form-card" onSubmit={handleSubmit}>
      <h3>Cadastrar novo colaborador</h3>
      <div className="form-group">
        <label>Nome</label>
        <input
          type="text"
          required
          value={name}
          onChange={e => setName(e.target.value)}
          className="input-main"
        />
      </div>
      <div className="form-group">
        <label>E-mail</label>
        <input
          type="email"
          required
          value={email}
          onChange={e => setEmail(e.target.value)}
          className="input-main"
        />
      </div>
      <div className="form-group">
        <label>Foto (URL)</label>
        <input
          type="text"
          value={picture}
          onChange={e => setPicture(e.target.value)}
          className="input-main"
        />
      </div>
      <div className="form-group">
        <label>Gestor</label>
        <select
          value={managerId}
          onChange={e => setManagerId(e.target.value)}
          className="input-main"
        >
          <option value="">Sem gestor</option>
          {managers.map(m => (
            <option value={m.id} key={m.id}>{m.name}</option>
          ))}
        </select>
      </div>
      <div style={{ marginTop: 18 }}>
        <button className="button-main" type="submit" disabled={loading}>
          {loading ? "Salvando..." : "Salvar"}
        </button>
        <button type="button" className="button-main" style={{ marginLeft: 12, background: "#fff", color: "#CD90FF", border: "2px solid #CD90FF" }} onClick={onCancel}>
          Cancelar
        </button>
      </div>
    </form>
  );
}
