# IECC (iecc)

A Flutter app for IECC student referral and admission management — register students, track status and get notifications.

## Features

- Student registration and add-student flow
- Student details and pending-status pages
- OTP verification and login
- Home dashboard with custom app bar
- Push notifications page
- Edit-profile page, splash screen

## Tech Stack

- Flutter (Dart)
- GetX for state management and routing
- REST API backend

## Getting Started

```bash
flutter pub get
flutter run
```

## Project Structure

```
lib/
├── app/modules/   # Home, registration, students, OTP/login, notifications
├── services/      # API and platform services
├── theme/         # App theme
└── main.dart      # App entry point
```

## Notes

- App label: "iecc" (Android)
- No secrets or keystores are committed to this repository.
