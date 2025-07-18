import React from "react";
import { Tree, TreeNode } from "react-organizational-chart";

const renderTree = (employees, managerId = null) => {
  const nodes = employees.filter(e => e.manager_id === managerId);

  return nodes.map(emp => (
    <TreeNode
      key={emp.id}
      label={
        <div style={{
          background: "#fff",
          border: "2px solid #CD90FF",
          borderRadius: "12px",
          minWidth: "150px",
          minHeight: "44px",
          margin: "8px",
          padding: "8px 12px",
          color: "#7648ab",
          fontWeight: 600,
          display: "flex",
          alignItems: "center"
        }}>
          <span style={{
            display: "inline-block",
            background: "#CD90FF",
            color: "#fff",
            borderRadius: "50%",
            width: 32,
            height: 32,
            textAlign: "center",
            lineHeight: "32px",
            fontWeight: 700,
            marginRight: 10
          }}>
            {emp.name[0]}
          </span>
          <span>
            {emp.name}
            <br />
            <span style={{ fontWeight: 400, fontSize: "0.93em", color: "#9b6bd4" }}>{emp.email}</span>
          </span>
        </div>
      }
    >
      {renderTree(employees, emp.id)}
    </TreeNode>
  ));
};

export default function OrgTree({ employees }) {
  return (
    <div style={{
      overflow: "auto",
      background: "#f2f0ef",
      borderRadius: "16px",
      padding: 24,
      minHeight: 350
    }}>
      <Tree
        lineWidth={'2px'}
        lineColor={'#CD90FF'}
        lineBorderRadius={'8px'}
        label={<div style={{ fontWeight: 700, color: "#7648ab", fontSize: 18, marginBottom: 10 }}>Organograma</div>}
      >
        {renderTree(employees, null)}
      </Tree>
    </div>
  );
}
