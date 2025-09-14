# Yeong Mood Tracker

A Flutter-based mood tracking application that helps users monitor and track their emotional well-being over time.

## Features

- **Mood Tracking**: Log and monitor your daily mood patterns
- **Multi-platform Support**: iOS, Android, Web, and macOS
- **Dark Mode**: System-adaptive and manual theme switching
- **Photo Integration**: Attach images to mood entries with gallery access
- **Cloud Sync**: Firebase backend for data synchronization
- **Offline Support**: Local storage with SharedPreferences

## Tech Stack

- **Framework**: Flutter (SDK >=2.18.6)
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Backend**: Firebase (Auth, Firestore, Storage)
- **Local Storage**: SharedPreferences
- **UI**: Custom design system with Pretendard fonts

## Getting Started

### Prerequisites

- Flutter SDK (>=2.18.6)
- Firebase account
- Platform-specific development environment (Android Studio, Xcode, etc.)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/yeong_mood_tracker.git
   cd yeong_mood_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   This project requires Firebase configuration files that are excluded from version control for security.

   ```bash
   # Install Firebase CLI and FlutterFire CLI
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli

   # Login to Firebase
   firebase login

   # Configure Firebase for your project
   flutterfire configure
   ```

   This will generate the required files:
   - `lib/firebase_options.dart`
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

4. **Run the app**
   ```bash
   flutter run
   ```

### Available Commands

```bash
# Development
flutter run                    # Debug mode
flutter run --release          # Release mode
flutter run -d chrome          # Web
flutter run -d android         # Android
flutter run -d ios             # iOS

# Build
flutter build apk              # Android APK
flutter build ios             # iOS
flutter build web             # Web

# Testing & Analysis
flutter test                   # Run tests
flutter analyze               # Static analysis
```

## Project Structure

```
lib/
├── constants/          # Design tokens (sizes, gaps, text styles)
├── models/            # Data models
├── repos/             # Repository layer for data access
├── view_models/       # Riverpod state management
├── main.dart          # App entry point
├── router.dart        # Navigation configuration
└── utils.dart         # Utility functions
```

## Architecture

This project follows a layered architecture pattern:

- **Presentation Layer**: Flutter widgets with Riverpod for state management
- **Business Logic**: ViewModels handle app state and business rules
- **Data Layer**: Repository pattern for data access (Firebase, SharedPreferences)

### Key Dependencies

- **flutter_riverpod**: State management and dependency injection
- **go_router**: Declarative navigation
- **firebase_core/auth/firestore/storage**: Backend services
- **image_picker & gal**: Photo capture and gallery access
- **permission_handler**: System permissions management

## Development

### Theme System

The app includes a comprehensive theme system with:
- Light/dark mode support with system preference detection
- Custom Pretendard font family
- Consistent spacing using design tokens
- Material Design 2 components

### Firebase Services

- **Authentication**: User registration and login
- **Firestore**: Mood data storage and synchronization
- **Storage**: Image attachment storage

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Security Notes

- Firebase configuration files contain API keys and are excluded from version control
- Set up your own Firebase project for development
- Never commit sensitive credentials to the repository

## License

This project is private and not licensed for public use.

---

Built with Flutter 💙