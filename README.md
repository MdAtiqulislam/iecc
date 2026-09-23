# IECC (iecc)

A Flutter app for IECC student referral and admission management — register students, track status and get notifications.

[![Google Play](https://img.shields.io/badge/Google_Play-Download-414141?style=for-the-badge&logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=com.revinr.iecc) [![App Store](https://img.shields.io/badge/App_Store-Download-0D96F2?style=for-the-badge&logo=app-store&logoColor=white)](https://apps.apple.com/app/id6499480422)


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
