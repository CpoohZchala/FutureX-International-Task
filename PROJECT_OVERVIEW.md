# FutureX International Mobile App - Project Overview

## 🎯 Purpose
This Flutter application serves as a user authentication and profile management system. it demonstrates a complete flow from registration to a logged-in dashboard, with persistent local storage and API integration.

## 📂 File Structure & Organization

### 🏗️ Core (lib/)
- **`main.dart`**: The application's entry point. It initializes the Flutter app and sets the `SplashScreen` as the initial home.

### 📱 Screens (lib/screens/)
- **`splash_screen.dart`**: The entry screen that handles initial logic. It checks if a user is already logged in by looking at local storage and verifying status with the backend.
- **`login_screen.dart`**: A clean user interface for existing users to sign in using their email and password.
- **`signup_screen.dart`**: A registration form for new users to create an account with username, email, password, and phone number.
- **`dashboard_screen.dart`**: The main user area that displays profile information once authenticated.

### ⚙️ Services & Logic (lib/services/ & lib/utils/)
- **`services/api_service.dart`**: Centralizes all network communication. It uses the `http` package to talk to the FutureX backend for login, signup, and status checks.
- **`utils/local_storage.dart`**: Manages data persistence using `shared_preferences`. It keeps the user logged in even after the app is closed.

### 📦 Data Models (lib/models/)
- **`user_model.dart`**: Defines the `User` data structure, making it easy to convert between JSON from the API and Dart objects used in the UI.

## 🔄 Application Flow
1. **Startup**: `SplashScreen` launches and checks for a stored `user_id`.
2. **Verification**: If an ID exists, it pings the API to ensure the account is still valid.
3. **Authentication**:
   - If no valid session is found, the user is sent to `LoginScreen`.
   - New users can navigate to `SignupScreen` from the login page.
4. **Dashboard**: Upon successful login/signup, user data is saved locally, and the user is redirected to the `DashboardScreen`.

## 🛠️ Technical Stack
- **Framework**: Flutter (Dart)
- **Networking**: `http` package for REST API calls.
- **Persistence**: `shared_preferences` for lightweight key-value storage.
- **Typography**: Google Fonts (Poppins) as specified in project requirements.
- **Testing**: Widget tests for UI verification.
