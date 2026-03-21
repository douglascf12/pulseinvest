# 📱 PulseInvest

PulseInvest is an iOS application built with UIKit that allows users to track cryptocurrency prices in real time.

This project is being developed as part of a structured study plan to master iOS development at a senior level.

---

## 🚀 Features (in progress)

- Fetch cryptocurrency market data from CoinGecko API
- Display asset list
- Search assets
- View asset details
- Favorite assets
- Offline caching
- Error handling
- Clean architecture

---

## 🧠 Architecture

The project follows a layered architecture:

### Layers

- **Presentation**: UIKit views and view controllers
- **Domain**: Entities and business rules
- **Data**: Repositories, DTOs, and mappers
- **Core**: Networking, error handling, utilities

---

## 🧩 Design Principles

- Protocol-oriented programming
- Dependency injection
- Separation of concerns
- Clean architecture
- Testability

---

## 🌐 Networking

- URLSession (async/await)
- Endpoint abstraction
- Centralized API client
- Custom error handling (AppError)

---

## ⚠️ Error Handling

The app uses a centralized error model:

- Network errors
- Invalid responses
- Decoding errors
- Unknown errors

---

## 🛠 Tech Stack

- Swift
- UIKit
- URLSession
- Async/Await
- Clean Architecture

---

## 📚 Learning Goals

This project is part of a daily learning plan covering:

- Swift fundamentals
- Memory management (ARC)
- Networking
- Architecture
- Testing
- Performance
- Accessibility

---

## 🔄 Git Flow

The project uses a feature branch strategy:

- `main` → stable
- `feature/day-X-*` → daily development

Each day:
- new branch
- PR
- merge

---

## 📈 Future Improvements

- Unit tests
- UI tests
- CI/CD pipeline
- Performance optimizations
- Accessibility improvements

---

## 👨‍💻 Author

Douglas Cardoso Ferreira

iOS Developer