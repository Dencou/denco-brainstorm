# 🧠 Denco Brainstorm App

A modern Brainstorming application built with **Flutter** and **Clean Architecture**, designed to be scalable, testable, and maintainable.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Architecture](https://img.shields.io/badge/Architecture-Clean-green)
![State](https://img.shields.io/badge/State-Bloc-red)

## ✨ Features

* **Idea Management:** Create new ideas and visualize them in real-time.
* **Smart Voting:** Toggle-based voting system (Like/Dislike) with simulated local persistence.
* **Discussions:** Detailed comment threads for every idea to foster collaboration.
* **Modern UI/UX:** Clean design with visual feedback, category tagging, and subtle animations.

## 💻 Modern Dart Features

This project leverages the latest capabilities of **Dart 3**, ensuring concise and robust code:

* **Sealed Classes:** Used for Bloc States (`sealed class IdeasState`) to enforce exhaustive type checking.
* **Pattern Matching:** Utilized in the UI layer to handle state changes declaratively, avoiding nested `if-else` chains.
* **Switch Expressions:** Replaces traditional switch-case statements for cleaner, more readable widget trees.

## 🏗️ Architecture & Tech Stack

The project adheres to **Clean Architecture** principles, decoupling the application into independent layers:

1.  **Presentation:** Logic (Cubits) & UI (Pages/Widgets).
2.  **Domain:** Entities, Use Cases & Repository Interfaces (Pure Dart).
3.  **Data:** Models, Repository Implementations & Data Sources.

### Core Libraries
* **State Management:** `flutter_bloc`
* **Dependency Injection:** `get_it` + `injectable`
* **Functional Programming:** `dartz` (for functional error handling with `Either`)
* **Immutability:** `equatable`
* **Routing:** `go_router`
* **Testing:** `bloc_test`, `mocktail`

## 🧪 Testing

The project includes Unit Tests for the Presentation layer (Cubits) to ensure business logic robustness.
## 🚀 How to run

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/dencou/denco_brainstorm.git](https://github.com/dencou/denco_brainstorm.git)
    cd denco_brainstorm
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Generate code (for DI and JSON):**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```
