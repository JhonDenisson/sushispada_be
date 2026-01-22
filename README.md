# 🍣 Sushi Spada - Backend API

API RESTful para sistema de delivery de restaurante japonês, construída com Ruby on Rails (API-only).

## 📋 Índice

- [Tecnologias](#-tecnologias)
- [Arquitetura](#-arquitetura)
- [Instalação](#-instalação)
- [Variáveis de Ambiente](#-variáveis-de-ambiente)
- [Executando o Projeto](#-executando-o-projeto)
- [Endpoints da API](#-endpoints-da-api)
- [Regras de Negócio](#-regras-de-negócio)
- [Estrutura do Projeto](#-estrutura-do-projeto)

---

## 🚀 Tecnologias

- **Ruby** 3.2.2
- **Rails** 8.1.1 (API-only)
- **PostgreSQL** - Banco de dados
- **Puma** - Web server
- **Docker** - Containerização

### Gems Principais

| Gem | Propósito |
|-----|-----------|
| `bcrypt` + `jwt` | Autenticação |
| `pundit` | Autorização |
| `blueprinter` | Serialização JSON |
| `kaminari` | Paginação |
| `rack-cors` | CORS |
| `kamal` | Deploy |

---

## 🏗 Arquitetura

O projeto segue uma arquitetura **API-first** com:

- **Controllers finos** - Apenas validam params, autorizam e delegam para services
- **Services** - Encapsulam regras de negócio (`app/services/`)
- **Queries** - Lógica de busca e filtros complexos (`app/queries/`)
- **Policies** - Autorização com Pundit (`app/policies/`)
- **Serializers** - Formatação de JSON com Blueprinter (`app/serializers/`)

---

## 💻 Instalação

### Pré-requisitos

- Ruby 3.2.2
- PostgreSQL 14+
- Bundler

### Setup

```bash
# Clone o repositório
git clone <repository-url>
cd sushispada_be

# Instale as dependências
bundle install

# Configure as variáveis de ambiente
cp .env.example .env.local

# Crie e configure o banco de dados
rails db:create db:migrate db:seed
```

### Com Docker

```bash
docker-compose up -d
```

---

## 🔐 Variáveis de Ambiente

Crie um arquivo `.env.local` baseado no `.env.example`:

```env
DATABASE_URL=postgres://user:password@localhost:5432/sushispada_development
JWT_SECRET_KEY=sua_chave_secreta_aqui
```

---

## ▶️ Executando o Projeto

```bash
# Desenvolvimento
rails server

# Com Docker
docker-compose up

# Health check
curl http://localhost:3000/up
```

---

## 📡 Endpoints da API

### Autenticação

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `POST` | `/auth/sign_up` | Cadastro de usuário |
| `POST` | `/auth/sign_in` | Login |
| `DELETE` | `/auth/sign_out` | Logout |
| `GET` | `/auth/me` | Dados do usuário autenticado |

### Área do Cliente (`/customers`)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET` | `/customers/categories` | Listar categorias |
| `GET` | `/customers/products` | Listar produtos |
| `GET` | `/customers/products/:id` | Detalhes do produto |
| `GET` | `/customers/addresses` | Listar endereços |
| `POST` | `/customers/addresses` | Criar endereço |
| `PUT` | `/customers/addresses/:id` | Atualizar endereço |
| `DELETE` | `/customers/addresses/:id` | Remover endereço |
| `POST` | `/customers/orders` | Criar pedido (draft) |
| `GET` | `/customers/orders/:id` | Detalhes do pedido |
| `POST` | `/customers/orders/:id/order_items` | Adicionar item |
| `PUT` | `/customers/orders/:order_id/order_items/:id` | Atualizar item |
| `DELETE` | `/customers/orders/:order_id/order_items/:id` | Remover item |
| `POST` | `/customers/orders/:id/checkout` | Finalizar pedido |

### Área Administrativa (`/admin`)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| `GET/POST` | `/admin/categories` | Listar/Criar categorias |
| `GET/PUT/DELETE` | `/admin/categories/:id` | CRUD categoria |
| `GET/POST` | `/admin/products` | Listar/Criar produtos |
| `GET/PUT/DELETE` | `/admin/products/:id` | CRUD produto |
| `GET` | `/admin/orders` | Listar pedidos |
| `PUT` | `/admin/orders/:id` | Atualizar status do pedido |

---

## 📜 Regras de Negócio

### Pedidos

1. **Estado Draft**: Pedidos novos nascem como `draft` e só aceitam modificações neste estado
2. **Preço Congelado**: O `OrderItem` salva `unit_price_cents` no momento da criação
3. **Snapshot de Endereço**: No checkout, os dados do endereço são copiados para campos `delivery_*` na order
4. **Cálculo Automático**: `Order#recalculate_totals!` soma itens + taxa de entrega - descontos

---

## 📁 Estrutura do Projeto

```
app/
├── controllers/
│   ├── auth/           # Autenticação (registrations, sessions)
│   ├── customers/      # Endpoints do cliente
│   └── admin/          # Endpoints administrativos
│
├── models/             # ActiveRecord models
│
├── services/           # Business logic
│   ├── auth/           # JWT service
│   └── orders/         # Add/Remove/Update items, Checkout
│
├── queries/            # Query objects
│
├── policies/           # Pundit authorization
│
├── serializers/        # Blueprinter serializers
│
└── jobs/               # Background jobs
```

---

## 🧪 Testes

```bash
# Executar todos os testes
bundle exec rspec

# Com cobertura
bundle exec rspec --format documentation
```

---

## 🚢 Deploy

O projeto utiliza [Kamal](https://kamal-deploy.org/) para deploy:

```bash
kamal setup    # Primeiro deploy
kamal deploy   # Deploys subsequentes
```

---

## 📝 Roadmap

- [ ] Implementar aplicação de cupons no checkout
- [ ] Integrar taxas de entrega dinâmicas por zona
- [ ] Ampliar cobertura de testes com RSpec
- [ ] Finalizar endpoints de DeliveryZones e Coupons

---

## 📄 Licença

Este projeto é privado e de uso exclusivo.
