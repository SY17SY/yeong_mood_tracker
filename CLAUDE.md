# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

### Development
```bash
# Get dependencies and build
flutter pub get
flutter pub upgrade

# Run the app
flutter run                    # Debug mode
flutter run --release          # Release mode
flutter run -d chrome          # Web
flutter run -d macos           # macOS
flutter run -d android         # Android
flutter run -d ios             # iOS

# Build
flutter build apk              # Android APK
flutter build ios             # iOS
flutter build web             # Web
flutter build macos           # macOS
```

### Code Quality
```bash
# Analysis and linting
flutter analyze               # Static analysis
flutter test                  # Run tests
flutter test test/widget_test.dart  # Run specific test

# Formatting
dart format lib/             # Format Dart code
```

### Firebase Integration
```bash
# Firebase CLI setup (if needed)
npm install -g firebase-tools
firebase login

# FlutterFire CLI (for Firebase config)
dart pub global activate flutterfire_cli
flutterfire configure        # Reconfigure Firebase
```

## Architecture

This is a Flutter mood tracking application using the following architecture:

### State Management
- **Riverpod** (`flutter_riverpod ^2.1.3`) for state management
- **Provider pattern** with NotifierProvider for reactive state
- Settings managed through `SettingsViewModel` and `SettingsRepository`

### Navigation
- **GoRouter** (`go_router 6.0.2`) for declarative routing
- Router configured in `lib/router.dart` with `routerProvider`
- Currently empty routes array - routes need to be added as screens are implemented

### Data Persistence
- **SharedPreferences** for local settings storage
- **Firebase** integration for cloud services:
  - Firebase Core, Auth, Firestore, and Storage configured
  - Project ID: `yeong-mood-tracker-0`
  - Multi-platform support (iOS, Android, Web)

### Design System
- **Custom theme** with light and dark mode support
- **Pretendard fonts** (Semibold and Medium variants)
- **Design tokens** in `lib/constants/`:
  - `sizes.dart` - spacing and size constants (d1, d2, d4, etc.)
  - `gaps.dart` - widget spacing gaps
  - `text.dart` - text style constants

### Directory Structure
```
lib/
├── constants/          # Design tokens and constants
├── models/            # Data models (SettingsModel)
├── repos/             # Repository layer (SettingsRepository)
├── view_models/       # Riverpod ViewModels (SettingsViewModel)
├── main.dart          # App entry point
├── router.dart        # Navigation configuration
├── utils.dart         # Utility functions
└── firebase_options.dart  # Firebase configuration
```

### Key Features
- **Theme Management**: System/manual dark mode toggle
- **Internationalization Ready**: Korean fonts (Pretendard) configured
- **Multi-platform**: iOS, Android, Web, macOS support configured
- **Image Handling**: Image picker and gallery access permissions setup

## Dependencies

### Core Dependencies
- `flutter_riverpod` - State management
- `go_router` - Navigation
- `shared_preferences` - Local storage
- `firebase_core/auth/firestore/storage` - Backend services

### UI/Media Dependencies
- `cupertino_icons`, `font_awesome_flutter` - Icons
- `image_picker`, `gal` - Photo/gallery access
- `permission_handler` - System permissions

## Development Notes

### Firebase Setup
Firebase is pre-configured for multiple platforms. Configuration files are automatically generated:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

### Theme System
The app uses a comprehensive theme system supporting:
- Light/dark mode with system preference detection
- Custom Pretendard font family across all text styles
- Consistent spacing using the Sizes class constants
- Material Design 2 (useMaterial3: false)

### Asset Management
Assets are organized in the `assets/` directory:
- `assets/fonts/` - Pretendard font files
- `assets/images/` - Image assets

### Code Style
- Uses standard Flutter lints (`package:flutter_lints/flutter.yaml`)
- Consistent naming: `d` prefix for dimension constants
- Repository pattern for data access
- ViewModel pattern with Riverpod for state management