# QultureOrgchart

**Desafio Fullstack — Organograma de Empresa (Ruby on Rails + React)**

---

## 🚀 Como rodar localmente

**Pré-requisitos:**

* Ruby 3.x e bundler
* Node.js (>= 16) e npm
* [foreman](https://github.com/ddollar/foreman):
  `gem install foreman`
* (Opcional) `rbenv` para gerenciamento de Ruby

### Passos

1. **Clone este repositório**

2. **Instale as dependências do backend (Rails):**

   ```bash
   cd QultureOrgChart
   bundle install
   ```

3. **Configure o banco de dados:**
   (Usa SQLite por padrão)

   ```bash
   rails db:setup
   ```

4. **Instale as dependências do frontend (React):**

   ```bash
   cd ./frontend
   npm install
   ```

5. **Rode o app inteiro (backend e frontend) em um comando:**
Na raiz do projeto, rode:

   ```bash
   bin/dev
   ```

   * Isso vai iniciar o Rails na porta `3000` e o React na porta `5100`.
   * Acesse o frontend em [http://localhost:5100](http://localhost:5100).

---

## 📝 Escopo (Épicos do Challenge)

### 1. Empresa

* **1.1.** Como usuário, quero cadastrar uma empresa (atributo: `name`)
* **1.2.** Como usuário, quero listar as empresas do sistema
* **1.3.** Como usuário, quero ver uma empresa (acessar colaboradores de cada empresa)

### 2. Colaboradores

* **2.1.** Como usuário, quero cadastrar um colaborador em uma empresa (atributos: `name`, `email`, `picture`, `manager_id` opcional)
* **2.2.** Como usuário, quero listar os colaboradores de uma empresa
* **2.3.** Como usuário, quero apagar um colaborador de uma empresa

### 3. Organograma

* **3.1.** Como usuário, quero associar um colaborador como gestor de outro usuário

  * Ambos precisam estar na mesma empresa
  * Cada usuário pode ter no máximo 1 gestor
  * Não permitir loops (um liderado não pode se tornar gestor de seu gestor)
* **3.2.** Como usuário, quero listar os pares de um colaborador (liderados do mesmo gestor)
* **3.3.** Como usuário, quero listar os liderados diretos de um colaborador
* **3.4.** Como usuário, quero listar os liderados de segundo nível de um colaborador
* **3.5.** Como usuário, quero visualizar o organograma de toda a empresa (hierarquia em árvore, com toggle)

---

## ⚙️ Decisões Técnicas

* **Backend:** Ruby on Rails 8, SQLite3 (para praticidade e portabilidade local), ActiveModelSerializers para APIs REST.
* **Frontend:** React (Create React App), JS puro (sem TypeScript para agilizar o setup), consumo da API via Axios.
* **Estilo:** Paleta roxa (`#CD90FF`) e cinza claro (`#F2F0EF`), UI com blocos retangulares, bordas arredondadas, botões estilizados com hover blur.
* **Arquitetura:** RESTful, separação clara de responsabilidades, componentes React reusáveis, código limpo e comentado.
* **UX:** Telas de listagem e cadastro, organograma visual com árvore hierárquica e alternância (toggle), confirmação para ações destrutivas.
* **Inicialização:** Utiliza `bin/dev` + `Procfile.dev` (Rails + React juntos), setup documentado para onboarding rápido.

---

## 📦 Funcionalidades implementadas

* Cadastro, listagem e visualização de empresas
* Cadastro, listagem, exclusão e edição de colaboradores
* Associação, edição e validação de gestor (incluindo prevenção de loops)
* Visualização do organograma como árvore hierárquica
* Interface moderna, responsiva e intuitiva
* API RESTful completa, testes unitários no backend

---

## 💡 Observações

* Todas as validações de regras de negócio (mesmo gestor, sem loops, empresa igual) implementadas no backend.
* A edição de gestor pode ser feita no momento do cadastro ou posteriormente, na tela de colaboradores.
* Assegurada a exclusão em cascata ao apagar empresas/colaboradores (se necessário).
* Testes unitários no backend disponíveis (via RSpec e FactoryBot).

---
