# WebSocket Chat Application

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0.0-blue.svg)](https://dart.dev/)
[![Dart Frog](https://img.shields.io/badge/Dart%20Frog-1.1.0-green.svg)](https://dartfrog.vgv.dev/)

Aplikasi chat real-time yang dibangun menggunakan WebSocket dengan Flutter sebagai client dan Dart Frog sebagai server backend. Proyek ini dibuat untuk tujuan pembelajaran implementasi WebSocket dalam aplikasi chat.

## 🏗️ Arsitektur

Aplikasi ini terdiri dari dua bagian utama:

### Client (Flutter)
- **Framework**: Flutter 3.8.1
- **State Management**: GetX
- **WebSocket**: web_socket_channel
- **UI**: Material Design dengan tema custom

### Server (Dart Frog)
- **Framework**: Dart Frog 1.1.0
- **WebSocket**: dart_frog_web_socket
- **Storage**: In-memory storage (untuk demo)

## 📁 Struktur Proyek

```
webSocket_chatApp/
├── client/                 # Flutter client application
│   ├── lib/
│   │   ├── main.dart      # Entry point aplikasi
│   │   ├── getx/          # GetX controllers
│   │   ├── model/         # Data models
│   │   └── screen/        # UI screens
│   └── pubspec.yaml       # Dependencies Flutter
├── server/                 # Dart Frog server
│   ├── routes/
│   │   ├── index.dart     # Home route
│   │   └── ws/            # WebSocket routes
│   ├── model/             # Server models
│   └── pubspec.yaml       # Dependencies server
└── README.md
```

## 🚀 Cara Menjalankan

### Prerequisites
- Flutter SDK (>= 3.8.1)
- Dart SDK (>= 3.0.0)
- IDE (VS Code/Android Studio)

### 1. Clone Repository
```bash
git clone https://github.com/ALFIAN-code/webSocket-chat-app.git
cd webSocket-chat-app
```

### 2. Setup Server
```bash
cd server
dart pub get
dart_frog dev
```
Server akan berjalan di `http://localhost:8080`

### 3. Setup Client
Buka terminal baru:
```bash
cd client
flutter pub get
flutter run
```

### 4. Testing WebSocket
Untuk testing WebSocket connection:
```bash
# Di terminal server, WebSocket endpoint tersedia di:
ws://localhost:8080/ws
```

## 🔧 Konfigurasi

### Client Configuration
Edit file `client/lib/getx/global_cotroller.dart` untuk mengubah URL server:
```dart
// Ganti dengan IP server Anda jika running di device fisik
final String serverUrl = 'ws://localhost:8080/ws';
```

### Server Configuration
Server default berjalan di port 8080. Untuk mengubah port, edit konfigurasi di Dart Frog.


## 🛠️ Teknologi yang Digunakan

### Frontend (Client)
- **Flutter**: Cross-platform mobile framework
- **GetX**: State management dan dependency injection
- **web_socket_channel**: WebSocket client implementation
- **Material Design**: UI components

### Backend (Server)
- **Dart Frog**: Backend framework untuk Dart
- **dart_frog_web_socket**: WebSocket server implementation
- **In-memory storage**: Temporary message storage
