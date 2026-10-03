# Changelog

## [1.0.2] - 2026-10-04

### Fixed
- Replace direct style assignments with Obsidian's `setCssStyles` to satisfy the community plugin guidelines
- Type-safe loading of persisted plugin data
- Await persistence writes instead of leaving a floating promise
- Use Obsidian's `createEl` helper instead of `document.createElement`
- Remove `!important` from drag-state styles
- Add `package-lock.json` for reproducible builds; drop the `builtin-modules` dependency

## [1.0.1] - 2026-10-03

### Fixed
- **Plugin failed to load at all**: manifest.json was invalid JSON (missing comma), so Obsidian silently skipped it (#5)
- **Column width capped at 500px**: hardcoded CSS `min/max-width !important` overrode the plugin settings; widths now follow the configured maximum (#4)
- **Persistence was broken**: an async `loadData()` misuse meant widths were never restored, and every drag overwrote the settings file with an empty object — settings and column widths are now stored correctly and separately
- **Dragging from rows below the header did not work**: handles were attached to every cell with a wrong column index; handles now live on header cells only, with correct indices
- Plugin styles no longer override borders, padding, backgrounds, or layout of all tables; only the resize handle itself is styled
- Tables switch to fixed layout while resizing so widths track the mouse precisely

### Changed
- Settings panel in English, with an enable/disable toggle; min/max width accept any positive value
- Removed the unused "default column width" setting

## [1.0.0] - 2025-11-15

### Added
- Initial release of Table Column Resizer plugin
- Drag-to-resize functionality for table columns in reading view
- Persistent column width settings
- Customizable minimum and maximum column widths
- Visual feedback with hover and drag indicators
