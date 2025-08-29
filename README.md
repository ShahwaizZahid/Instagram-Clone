# 📱 Instagram Clone - Flutter App

A fully functional Instagram clone built with Flutter and Firebase, featuring all the core functionalities of the popular social media platform.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## 🌟 Features

### 🔐 Authentication

- **User Registration** - Create new accounts with email and password
- **User Login** - Secure authentication with Firebase Auth
- **Auto Login** - Persistent user sessions
- **Logout** - Secure session termination

### 📸 Post Management

- **Create Posts** - Upload photos with captions
- **View Feed** - Browse posts from all users
- **Like Posts** - Interactive like functionality with animations
- **Comment System** - Add and view comments on posts
- **Save Posts** - Bookmark favorite posts
- **Share Posts** - Share content with others

### 🎬 Reels Feature

- **Create Reels** - Upload and edit short videos
- **Reels Feed** - Vertical scrolling video feed
- **Video Player** - Smooth video playback with controls
- **Reel Interactions** - Like, comment, and share reels

### 👤 User Profile

- **Profile Management** - View and edit user profiles
- **User Posts Grid** - Display user's posts in grid layout
- **User Reels Grid** - Display user's reels collection
- **Follow System** - Follow/unfollow other users
- **Profile Statistics** - Posts, followers, following counts

### 🔍 Explore & Discovery

- **Explore Feed** - Discover new content and users
- **Search Functionality** - Find users and content
- **Trending Content** - Popular posts and reels

### 📱 User Interface

- **Instagram-like Design** - Authentic Instagram UI/UX
- **Responsive Layout** - Optimized for different screen sizes
- **Smooth Animations** - Like animations and transitions
- **Dark/Light Theme Support** - Adaptive UI themes
- **Splash Screen** - Animated app launch screen

## 🛠️ Tech Stack

### Frontend

- **Flutter** - Cross-platform mobile development framework
- **Dart** - Programming language
- **Flutter ScreenUtil** - Responsive UI design
- **Cached Network Image** - Efficient image loading and caching
- **Staggered Grid View** - Advanced grid layouts

### Backend & Services

- **Firebase Core** - Firebase SDK initialization
- **Firebase Auth** - User authentication
- **Cloud Firestore** - NoSQL database for storing posts, users, comments
- **Firebase Storage** - File storage for images and videos

### Media & UI Components

- **Image Picker** - Camera and gallery access
- **Photo Manager** - Advanced photo management
- **Video Player** - Video playback functionality
- **Chewie** - Advanced video player controls
- **VLC Player** - Alternative video player
- **Animated Splash Screen** - App launch animations

### Utilities

- **UUID** - Unique identifier generation
- **Date Format** - Date and time formatting
- **Flutter Launcher Icons** - Custom app icons

## 📁 Project Structure

```
lib/
├── auth/                    # Authentication screens and logic
│   ├── auth_screen.dart     # Authentication wrapper
│   └── mainpage.dart        # Main navigation page
├── data/                    # Data layer
│   ├── firebase_services/   # Firebase service implementations
│   └── model/              # Data models
├── screen/                  # UI screens
│   ├── home_screen.dart     # Main feed screen
│   ├── explore_screen.dart  # Explore/discovery screen
│   ├── add_screen.dart      # Add content screen
│   ├── reel_screen.dart     # Reels feed screen
│   ├── profile_screen.dart  # User profile screen
│   ├── login_screen.dart    # Login screen
│   ├── signup_screen.dart   # Registration screen
│   ├── add_post_screen.dart # Create post screen
│   ├── add_reel_screen.dart # Create reel screen
│   └── post_screen.dart     # Individual post view
├── widgets/                 # Reusable UI components
│   ├── post_widget.dart     # Post display widget
│   ├── reels_item.dart      # Reel item widget
│   ├── comment.dart         # Comment widget
│   ├── like_animation.dart  # Like animation widget
│   ├── navigation.dart      # Bottom navigation
│   └── profile_head.dart    # Profile header widget
├── util/                    # Utility functions
│   ├── dialog.dart          # Dialog utilities
│   ├── exception.dart       # Error handling
│   ├── image_cached.dart    # Image caching utilities
│   └── imagepicker.dart     # Image picker utilities
├── firebase_options.dart    # Firebase configuration
└── main.dart               # App entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.5.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase account
- Android/iOS device or emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/instagram-clone.git
   cd instagram-clone
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication (Email/Password)
   - Enable Cloud Firestore
   - Enable Firebase Storage
   - Download and add configuration files:
     - `google-services.json` for Android (place in `android/app/`)
     - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)

4. **Configure Firebase**

   ```bash
   flutter pub global activate flutterfire_cli
   flutterfire configure
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Android Setup

- Minimum SDK: 21
- Target SDK: 36
- Compile SDK: 36
- Java Version: 17
- Kotlin Version: 2.0.21
- Gradle Version: 8.10.2
- Android Gradle Plugin: 8.7.2

### iOS Setup

- iOS Deployment Target: 12.0
- Xcode 14.0 or later

### Firebase Rules

**Firestore Security Rules:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

**Storage Security Rules:**

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## 📱 Screenshots

| Home Feed                     | Reels                           | Profile                             | Add Post                              |
| ----------------------------- | ------------------------------- | ----------------------------------- | ------------------------------------- |
| ![Home](screenshots/home.png) | ![Reels](screenshots/reels.png) | ![Profile](screenshots/profile.png) | ![Add Post](screenshots/add_post.png) |

## 🎯 Key Features Implementation

### Authentication Flow

- Firebase Authentication integration
- Persistent login state management
- Secure user session handling

### Real-time Data

- Cloud Firestore for real-time updates
- Efficient data synchronization
- Optimized queries for performance

### Media Handling

- Image compression and optimization
- Video upload and streaming
- Efficient caching mechanisms

### Performance Optimizations

- Lazy loading for feeds
- Image caching with `cached_network_image`
- Efficient memory management
- Smooth scrolling performance

## 🔄 State Management

- Provider pattern for state management
- Efficient widget rebuilding
- Clean separation of concerns

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📦 Build & Release

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Instagram for design inspiration
- Open source community for various packages

## 📞 Support

If you have any questions or need help, please:

- Open an issue on GitHub
- Contact: [your-email@example.com]

## 🔮 Future Enhancements

- [ ] Stories feature
- [ ] Direct messaging
- [ ] Live streaming
- [ ] Advanced filters and effects
- [ ] Push notifications
- [ ] Multi-language support
- [ ] Offline mode
- [ ] Advanced analytics

---

**Made with ❤️ using Flutter**

# Instragran_clone
