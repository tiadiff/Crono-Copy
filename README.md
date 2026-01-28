# Crono-Copy (v1.0.0)

A lightweight, native macOS menu bar application to track and manage your clipboard history.

## 🚀 Features

- **Background Operation**: Runs silently in the macOS menu bar (Menu Bar Extra).
- **Auto-Capture**: Automatically saves any text copied to the clipboard (`CMD+C`).
- **Quick Recall**: Click the menu bar icon to view the last 20 copied items. Clicking an item copies it back to your clipboard.
- **Persistent Storage**: History is saved in a local `history.json` file.
- **Reset History**: Easily clear your entire history with one click.
- **Native Look & Feel**: Uses SF Symbols and follows macOS design guidelines, supporting both Light and Dark modes.
- **No Dock Icon**: Stays out of your workspace by only appearing in the menu bar.

## 🛠 Installation

1. Download the `ClipboardHistory.app`.
2. Move it to your `/Applications` folder (optional).
3. Double-click to run.

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
