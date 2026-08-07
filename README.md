# 📚 BookShelf

**BookShelf** is a smart local PDF organizer and digital ebook reader designed for digital readers. It automatically classifies uploaded or imported PDFs (into categories like Manga/Comics, Web Novels, Light Novels, Textbooks, and General Documents), prompts users to organize them into categorized physical directories, fetches high-resolution cover posters, and presents a modern **Netflix-Style Home Interface**.

---

## 🔒 Security & Privacy Audit

Your security and private data are fully protected. All sensitive configuration files, environment variables, credentials, and local build caches are explicitly excluded from Git tracking via `.gitignore`:

- ✅ `.env*` / `*.env` (Environment secret variables)
- ✅ `key.properties` / `*.keystore` / `*.jks` / `*.pem` (Signing keys & certificates)
- ✅ `local.properties` / `android/local.properties` (Local system SDK paths)
- ✅ `.idea/` / `.vscode/` (Local IDE workspace settings)
- ✅ `.dart_tool/` / `build/` (Temporary build output binaries)

---

## 🚀 How to Run BookShelf on Any Device

### 📱 1. Running & Testing on iPhone / iOS Devices (Local Wi-Fi)

To test BookShelf live on your real iPhone without needing a Mac or Xcode:

1. Connect your **iPhone** and **PC** to the **same Wi-Fi network**.
2. Open terminal in the project directory and run:
   ```bash
   flutter run -d web-server --web-port 8085 --web-hostname 0.0.0.0 --release
   ```
3. Find your PC's IP address:
   - Open Command Prompt and type `ipconfig`. Look for **IPv4 Address** (e.g., `192.168.1.15`).
4. On your **iPhone**:
   - Open **Safari** and go to `http://<YOUR_PC_IP>:8085` (e.g., `http://192.168.1.15:8085`).
   - Tap **Share 📤** $\rightarrow$ **Add to Home Screen** to install it as an app icon on your iPhone!

---

### 💻 2. Running on Laptop / Desktop Browser (Chrome or Edge)

To run the app directly in your desktop web browser:

1. Run the web server in terminal:
   ```bash
   flutter run -d chrome
   ```
   *or manually via local web server:*
   ```bash
   flutter run -d web-server --web-port 8080 --release
   ```
2. Open `http://localhost:8080` in Chrome or Edge.
3. **Mobile Phone View**: Press `F12` (Inspect) $\rightarrow$ press `Ctrl + Shift + M` to toggle Chrome's Mobile Phone Toolbar.

---

### 🤖 3. Running in Android Studio (Emulator or Physical Android Phone)

1. Open the project in **Android Studio**.
2. Make sure the **Flutter & Dart plugins** are enabled (`Settings -> Plugins`).
3. In the top toolbar next to the green **Play (▶️)** button:
   - Select **`main.dart`** as the run configuration.
   - Select **`Pixel 8`** (or your connected Android phone) as the target device.
4. Click **Play (▶️)** to build and launch on your Android device.

---

### 📦 4. Building & Installing a Standalone Android APK

To generate a deployable release `.apk` installer file for testing on any Android phone:

```bash
flutter build apk
```

The output APK will be saved at:
`build/app/outputs/flutter-apk/app-release.apk`

#### 📲 Installing on Your Phone:
1. Transfer `app-release.apk` to your phone's Downloads folder (via USB, Google Drive, or Email).
2. Tap the APK file in your phone's **File Manager** to install.
3. **Google Play Protect Notice**: Because custom test APKs are self-signed, Play Protect will display a warning dialog. Tap **"Install anyway"** *(the text link directly above the blue OK button)* to proceed with installation.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: Flutter (Dart) — Cross-platform iOS, Android, and Web.
- **Architecture**: Clean Architecture (Feature-First pattern).
- **Heuristic Classifier**: Offline text-to-page density & keyword scanner engine (`lib/features/pdf_classifier`).
- **Metadata Pipeline**: Google Books REST API & AniList GraphQL API with local PDF Page 1 cover fallback.
- **UI Design**: Netflix-Style dark UI (`#141414`), Hero Banner, Recently Read cards (*"Page 142 / 350 • 41%"*), and Categorized Feed Rows.
