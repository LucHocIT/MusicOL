# MusicOL

Ứng dụng nghe nhạc đa nền tảng (Web, Android, iOS) được xây dựng bằng Flutter và Firebase.

## Tính năng

- ✅ **Xác thực**: Đăng nhập với Google
- 🎵 **Phát nhạc**: Engine âm thanh với background playback
- 📱 **Đa nền tảng**: Web, Android, iOS
- 🔐 **Phân quyền**: User/Editor/Admin roles
- 📂 **Playlist**: Tạo và quản lý danh sách phát
- 🔍 **Tìm kiếm**: Tìm kiếm theo từ khóa và bộ lọc
- 📱 **Offline**: Tải nhạc về máy để nghe offline

## Cài đặt

### Yêu cầu

- Flutter SDK ≥ 3.22
- Firebase project (cho production)

### Cài đặt dependencies

```bash
flutter pub get
```

### Tạo code generated

```bash
flutter packages pub run build_runner build
```

### Chạy ứng dụng

```bash
# Web
flutter run -d web-server --web-port 3000

# Android
flutter run -d android

# iOS
flutter run -d ios
```

## Kiến trúc

Dự án sử dụng **Clean Architecture + Feature-first**:

```
lib/
├── app/                    # App configuration, routing, DI
├── core/                   # Shared utilities, constants
└── features/
    └── auth/              # Authentication feature
        ├── data/          # Data sources, repositories impl
        ├── domain/        # Entities, repositories, use cases
        └── presentation/  # Controllers, pages, widgets
```

### Tech Stack

- **State Management**: Riverpod
- **Routing**: go_router  
- **Audio**: just_audio + audio_service
- **Backend**: Firebase (Auth, Firestore, Storage, Functions)
- **Models**: freezed + json_serializable
- **Testing**: flutter_test + mocktail

## Testing

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/features/auth/domain/usecases/sign_in_with_google_test.dart
```

## Firebase Setup

1. Tạo Firebase project tại [Firebase Console](https://console.firebase.google.com)

2. Cài đặt FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

3. Cấu hình Firebase cho dự án:
```bash
flutterfire configure
```

4. Enable Authentication với Google provider

5. Tạo Firestore database với Security Rules

## Cấu trúc Database

### Firestore Collections

- `users/{uid}`: Thông tin user và settings
- `tracks/{trackId}`: Metadata bài hát
- `albums/{albumId}`: Thông tin album
- `artists/{artistId}`: Thông tin nghệ sĩ
- `playlists/{playlistId}`: Danh sách phát

### Firebase Storage

```
/musicol/
├── covers/               # Ảnh bìa
├── audio/                # File âm thanh
└── artists/              # Avatar nghệ sĩ
```

## Development

### Code Style

- Tuân thủ [Dart Style Guide](https://dart.dev/guides/language/effective-dart)
- Sử dụng `flutter format` để format code
- Chạy `flutter analyze` để kiểm tra linting

### Git Workflow

- `main`: Production branch
- `develop`: Development branch
- `feat/*`: Feature branches
- `fix/*`: Bug fix branches

### Commit Convention

Sử dụng [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add user authentication
fix: resolve audio playback issue
docs: update README
```

## Roadmap

- [ ] Player UI với queue management
- [ ] Search functionality
- [ ] Playlist CRUD
- [ ] Offline downloads
- [ ] Admin dashboard
- [ ] Social features (comments, sharing)

## Contributing

1. Fork project
2. Tạo feature branch: `git checkout -b feat/amazing-feature`
3. Commit changes: `git commit -m 'feat: add amazing feature'`
4. Push branch: `git push origin feat/amazing-feature`
5. Tạo Pull Request

## License

This project is licensed under the MIT License.
