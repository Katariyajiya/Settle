<div align="center">

<br/>

```
  ███████╗███████╗████████╗████████╗██╗     ███████╗
  ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║     ██╔════╝
  ███████╗█████╗     ██║      ██║   ██║     █████╗  
  ╚════██║██╔══╝     ██║      ██║   ██║     ██╔══╝  
  ███████║███████╗   ██║      ██║   ███████╗███████╗
  ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝
```

### **Smart Group Expense & Settlement Platform**

*Spend memories, not time calculating expenses.*

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.x-6DB33F?style=for-the-badge&logo=springboot&logoColor=white)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://postgresql.org)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![MIT License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

<br/>

</div>

---

## 📖 About

Managing group expenses turns chaotic fast — someone pays for dinner, another covers the cab, a third books the hotel, and by the end of the trip, no one knows who owes whom. Settle fixes this.

Settle is a **full-stack expense-sharing platform** built for real-world group scenarios — trips, college outings, shared living, team events. It tracks every rupee, calculates net balances in real time, and uses **debt simplification algorithms** to reduce the number of transactions needed for a clean settlement.

> Built with Flutter (mobile), Spring Boot (backend), and PostgreSQL — a production-grade architecture from day one.

---

## ✨ Features

<details>
<summary><b>🔐 Authentication & Security</b></summary>
<br/>

- JWT-based stateless authentication
- Secure registration & login flow
- Protected API routes via Spring Security
- Role-based access control (admin / member)

</details>

<details>
<summary><b>🗺️ Trip Management</b></summary>
<br/>

- Create and manage trips with a name, date range, and description
- Invite participants via username or email
- View trip summary: total spent, balance status, member count
- Archive completed trips

</details>

<details>
<summary><b>💸 Expense Management</b></summary>
<br/>

- Add, edit, and delete expenses
- Record who paid and who participated
- Categorize expenses (food, transport, accommodation, etc.)
- Full expense history with timestamps

</details>

<details>
<summary><b>⚖️ Smart Splitting</b></summary>
<br/>

| Mode | Description |
|------|-------------|
| **Equal Split** | Divide equally among selected participants |
| **Exact Amount** | Manually assign specific amounts to each person |
| **Percentage Split** | Assign custom percentage shares |

</details>

<details>
<summary><b>🧮 Debt Simplification (Core Algorithm)</b></summary>
<br/>

Settle minimizes the total number of transactions using a greedy debt-simplification algorithm.

**Without Settle:**
```
A → B  ₹500
B → C  ₹500
C → D  ₹300
A → C  ₹200
```
*4 transactions needed*

**With Settle:**
```
A → C  ₹700
A → D  ₹300
```
*2 transactions. Same result. Less hassle.*

The algorithm works by computing net balances for each member and pairing the largest creditor with the largest debtor iteratively — reducing O(n²) transactions to near-optimal.

</details>

<details>
<summary><b>📊 Analytics Dashboard</b></summary>
<br/>

- Total trip expenditure overview
- Category-wise spending breakdown
- Per-member contribution analysis
- Top spender leaderboard
- Expense timeline view

</details>

<details>
<summary><b>🤝 Settlement Tracking</b></summary>
<br/>

- Mark individual debts as settled
- Full settlement history with timestamps
- Transaction timeline per member

</details>

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Mobile Frontend** | Flutter (Dart), Provider / Riverpod, Material 3 |
| **Backend** | Java 17, Spring Boot 3, Spring Security, Spring Data JPA |
| **ORM** | Hibernate |
| **Database** | PostgreSQL (primary) / MySQL (alternate) |
| **API Docs** | Swagger / OpenAPI 3 |
| **Containerization** | Docker, Docker Compose |
| **Dev Tools** | Postman, Git, GitHub |

---

## 🏗️ Architecture

```
┌─────────────────────────────────┐
│         Flutter Mobile App      │
│   (Dart · Provider · Material)  │
└────────────────┬────────────────┘
                 │  HTTPS / REST API
                 ▼
┌─────────────────────────────────┐
│      Spring Boot Backend        │
│                                 │
│  ┌──────────┐  ┌─────────────┐  │
│  │ Security │  │  Swagger UI │  │
│  │  (JWT)   │  │  /api-docs  │  │
│  └──────────┘  └─────────────┘  │
│                                 │
│  Controller → Service → Repo    │
└────────────────┬────────────────┘
                 │  JPA / Hibernate
                 ▼
┌─────────────────────────────────┐
│        PostgreSQL Database      │
│   Users · Trips · Expenses ·    │
│   Settlements · Categories      │
└─────────────────────────────────┘
```

---

## 📁 Project Structure

```
Settle/
│
├── frontend/                    # Flutter application
│   ├── lib/
│   │   ├── screens/             # UI screens (home, trip, expense, etc.)
│   │   ├── widgets/             # Reusable UI components
│   │   ├── services/            # API service layer
│   │   ├── providers/           # State management
│   │   └── models/              # Dart data models
│   └── assets/                  # Images, fonts, icons
│
├── backend/                     # Spring Boot application
│   └── src/main/java/
│       ├── controller/          # REST controllers
│       ├── service/             # Business logic
│       ├── repository/          # JPA repositories
│       ├── entity/              # Database entities
│       ├── dto/                 # Request / Response DTOs
│       ├── security/            # JWT config, filters
│       └── config/              # App & Swagger config
│
├── docker-compose.yml
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Java `17+`
- Maven `3.8+`
- PostgreSQL `14+`
- Docker & Docker Compose *(optional)*

---

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/Settle.git
cd Settle
```

---

### 2. Backend Setup

**Configure the database** in `backend/src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/settle_db
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update

jwt.secret=your_jwt_secret_key
jwt.expiration=86400000
```

**Run the backend:**

```bash
cd backend
./mvnw spring-boot:run
```

Backend will start at `http://localhost:8080`

API docs available at:
```
http://localhost:8080/swagger-ui/index.html
```

---

### 3. Frontend Setup

```bash
cd frontend
flutter pub get
flutter run
```

> Make sure your emulator/device is running. Update the base API URL in `lib/services/api_service.dart` to point to your backend.

---

### 4. Docker Setup *(Recommended)*

```bash
docker-compose up --build
```

This spins up the backend and PostgreSQL database together.

---

## 📡 API Overview

| Module | Endpoint | Method | Description |
|--------|----------|--------|-------------|
| Auth | `/api/auth/register` | POST | Register new user |
| Auth | `/api/auth/login` | POST | Login, returns JWT |
| Trips | `/api/trips` | GET / POST | List or create trips |
| Trips | `/api/trips/{id}` | GET / PUT / DELETE | Manage a trip |
| Expenses | `/api/trips/{id}/expenses` | GET / POST | List or add expenses |
| Expenses | `/api/expenses/{id}` | PUT / DELETE | Update or delete expense |
| Balances | `/api/trips/{id}/balances` | GET | Get member balances |
| Settlements | `/api/trips/{id}/settle` | GET | Get optimized settlements |
| Settlements | `/api/settlements/{id}/mark` | PATCH | Mark a settlement as paid |

> Full documentation with request/response schemas at `/swagger-ui/index.html`.

---

## 🗺️ Roadmap

- [x] JWT Authentication
- [x] Trip & Expense Management
- [x] Equal / Exact / Percentage Splitting
- [x] Debt Simplification Algorithm
- [x] Balance Tracking
- [x] Swagger API Docs
- [ ] Receipt Scanning (OCR)
- [ ] AI-based Expense Categorization
- [ ] Real-Time Notifications (WebSocket)
- [ ] UPI Payment Integration
- [ ] Multi-Currency Support
- [ ] Group Chat Feature
- [ ] AWS Deployment
- [ ] CI/CD Pipeline
- [ ] Expense Forecasting

---

## 👩‍💻 Author

 ##### Jiya Katariya - No more mental math on vacation, bestie's.


---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Travel together. Split smarter. Settle faster.** 🚀

*If this project helped you or you found it interesting, consider giving it a ⭐*

</div>
