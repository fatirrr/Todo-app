# Flutter Todo App

Aplikasi Flutter sederhana untuk menampilkan data todo dari sumber eksternal (JSONPlaceholder API).

## 📱 Fitur

- ✅ Menampilkan daftar todos dari API eksternal
- 🔍 Pencarian todos berdasarkan judul
- 🔄 Filter berdasarkan status (All/Completed/Pending)
- 📋 Detail view untuk setiap todo
- ↻ Pull to refresh untuk memuat ulang data
- 🎨 UI yang responsive dan user-friendly

## 🚀 Teknologi yang Digunakan

- **Flutter** - Framework utama
- **Dart** - Bahasa pemrograman
- **HTTP Package** - Untuk API calls
- **JSONPlaceholder API** - Sumber data eksternal

## 📡 API Endpoint

Data diambil dari: `https://jsonplaceholder.typicode.com/todos/`

## 🏗️ Struktur Project

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/
│   └── todo.dart            # Model data Todo
├── services/
│   └── api_service.dart     # Service untuk API calls
└── screens/
    ├── todo_list_screen.dart    # Screen utama (list todos)
    └── todo_detail_screen.dart  # Screen detail todo
```

## 🛠️ Cara Menjalankan

1. **Clone repository:**
   ```bash
   git clone https://github.com/username/flutter-todo-app.git
   cd flutter-todo-app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi:**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  cupertino_icons: ^1.0.2
```

## 📸 Screenshots

### Daftar Todos
- Menampilkan semua todos dengan status completed/pending
- Fitur pencarian dan filter
- Pull to refresh

### Detail Todo
- Informasi lengkap todo item
- Status visual yang jelas
- ID todo dan user ID

## 🔄 Cara Kerja

1. Aplikasi melakukan HTTP GET request ke JSONPlaceholder API
2. Data JSON di-parse menjadi objek Todo menggunakan model
3. Data ditampilkan dalam ListView dengan CardWidget
4. User dapat melakukan pencarian, filter, dan melihat detail

## 👨‍💻 Dibuat Oleh

M. Al Faiz - [60200123032] - Tugas Pemrograman Perangkat Bergerak
