# Changelog

## [1.0.2] - 2026-01-29

### Added
- Standard macOS persistence: Clipboard history is now stored in the `~/Library/Application Support/com.user.clipboardhistory/` directory.
- Automatic migration: Existing `history.json` files in the application's root directory are automatically moved to the new persistent location on first launch.
- Directory management: The application now automatically creates the necessary Application Support directory if it does not exist.

### Fixed
- Fixed an issue where clipboard history was lost when the application was closed or restarted due to varying working directories.
- Improved reliability of history loading and saving by using a unified, system-standard path.
