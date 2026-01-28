# Crono-Copy (v1.0.0)

A lightweight, native macOS menu bar application to track and manage your clipboard history.

## 🚀 Features

- **Background Operation**: Runs silently in the macOS menu bar.
- **Icon**: Look for the **Double Document icon** (📋/SF Symbol `doc.on.clipboard`) in your top right menu bar.
- **Auto-Capture**: Automatically saves any text copied to the clipboard (`CMD+C`).
- **Quick Recall**: Click the menu bar icon to view history. Clicking an item copies it back.
- **Persistent Storage**: Saved in `history.json`.
- **Native Design**: Gray-tinted icon compatible with both Light and Dark modes.

## 🛠 Installation & Usage

1. **Download & Run**: You can start the program directly by double-clicking the `ClipboardHistory.app` included in this repository.
2. **First Run**: Since it's an unsigned app, you might need to Right-Click -> Open, or allow it in System Settings -> Privacy & Security.
3. **Menu Bar**: Once launched, it will only appear in the top-right menu bar. No Dock icon will be visible.


## 🏗 How to Build from Source

If you want to compile the application yourself, you need **Swift** installed (included with Xcode Command Line Tools).

1. Clone the repository:
   ```bash
   git clone https://github.com/tiadiff/Crono-Copy.git
   cd Crono-Copy
   ```
2. Build the application using the provided script:
   ```bash
   sh build_app.sh
   ```
3. The `ClipboardHistory.app` will be generated in the current directory.

## 📄 License
This project is open-source and available for personal use.
