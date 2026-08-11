# task_management
A Client Tracker App

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

* [FVM](https://fvm.app/)
* Git
* Android Studio (for Android development)
* Xcode (for iOS development)

Verify FVM installation:

```bash
fvm --version
```

### 📦 Installation

1. Clone the repository:

```bash
git clone <repository-url>
cd <project-directory>
```

2. Install the project's Flutter SDK version:

```bash
fvm install
```

3. Get Flutter dependencies:

```bash
fvm flutter pub get
```

4. Run the application:

```bash
fvm flutter run
```

### 📱 Run on a Specific Platform

#### Android

```bash
fvm flutter run -d android
```

#### iOS

```bash
fvm flutter run -d ios
```

#### Web

```bash
fvm flutter run -d chrome
```

### 🛠️ Build

Build an Android APK:

```bash
fvm flutter build apk
```

Build an iOS application:

```bash
fvm flutter build ios
```

### 🧹 Troubleshooting

If you encounter dependency or build issues:

```bash
fvm flutter clean
fvm flutter pub get
fvm flutter run
```

Check the Flutter version:

```bash
fvm flutter --version
```

Check available devices:

```bash
fvm flutter devices
```

### 📌 Flutter Version

This project uses the Flutter version configured in:

```text
.fvmrc
```

Always use `fvm flutter` instead of `flutter` to ensure the project runs with the correct Flutter SDK version.


## ✨ Features Implemented

* **Project Management**

  * Add new projects
  * Edit existing projects
  * Update project details
  * View project information
  * Delete projects

* **BLoC State Management**

  * Implemented using the **BLoC pattern** for predictable and maintainable state management.
  * Separates business logic from the UI layer.

* **Persistent Storage**

  * Project data is stored locally for persistence between application sessions.
  * Data remains available after closing and reopening the application.
