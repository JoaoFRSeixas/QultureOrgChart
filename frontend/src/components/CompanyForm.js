import React, { useState } from "react";

export default function CompanyForm({ onSave, onCancel }) {
  const [name, setName] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    await onSave({ name });
    setName("");
    setLoading(false);
  };

  return (
    <form className="form-card" onSubmit={handleSubmit}>
      <h3>Cadastrar nova empresa</h3>
      <div className="form-group">
        <label>Nome da empresa</label>
        <input
          type="text"
          required
          value={name}
          onChange={e => setName(e.target.value)}
          className="input-main"
        />
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
