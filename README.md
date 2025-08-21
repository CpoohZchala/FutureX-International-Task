# FutureX International Mobile App

A Flutter application built for the FutureX International Mobile Developer Internship task. This app demonstrates a complete user authentication flow with API integration and local data persistence.

## Features

- **Splash Screen** with automatic user status detection
- **User Login** with email and password validation
- **User Registration** with comprehensive form validation
- **Dashboard** displaying user profile information
- **Local Storage** for persistent user data
- **API Integration** with FutureX backend services
- **Clean, Professional UI** with Poppins font family
- **Error Handling** and loading states

## API Endpoints

The app integrates with the following FutureX International API endpoints:

1. **Check Status** - `https://futurex.lk/api/checkstatus.php`
2. **User Login** - `https://futurex.lk/api/login.php`
3. **User Signup** - `https://futurex.lk/api/signup.php`

All API requests use POST method with JSON format.

## Response Codes

- `FX100` - Login successful
- `FX2000` - Signup successful
- `FX404` - User not found or invalid credentials
- `FX409` - Email already registered
- `FX3005` - Missing required data

## Installation

### Prerequisites

- Flutter SDK (version 3.0.0 or higher)
- Dart SDK (version 2.17.0 or higher)
- Android Studio or VS Code with Flutter extension

### Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd futurex_international
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### For Android

```bash
flutter run -d android
```

### For iOS

```bash
flutter run -d ios
```

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/
│   └── user.dart            # User data model
├── services/
│   └── api_service.dart     # API communication service
├── utils/
│   └── storage.dart         # Local storage utilities
└── screens/
    ├── splash_screen.dart   # Initial loading screen
    ├── login_screen.dart    # User login interface
    ├── signup_screen.dart   # User registration interface
    └── dashboard_screen.dart # User profile dashboard
```

## Dependencies

- **http**: ^1.1.0 - For making HTTP requests to APIs
- **shared_preferences**: ^2.2.2 - For local data storage
- **google_fonts**: ^4.0.4 - For Poppins font family

- **Email**: navindu@example.com
- **Password**: abc12345

### App Flow

1. **Splash Screen**: The app checks if a user ID exists in local storage
2. **Status Check**: If user exists, checks registration status with API
3. **Login/Signup**: Unregistered users are directed to authentication screens
4. **Dashboard**: Successful login leads to the user profile dashboard

