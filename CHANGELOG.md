# Changelog

## [1.1.0] - 2026-10-05

### Added
- Touch and stylus support: drag handling switched from mouse events to Pointer Events, with pointer capture so tracking continues when the pointer leaves the window and `touch-action: none` on the handle so touch drags are not hijacked by scrolling
- Saved widths for notes that no longer exist are pruned on plugin load, and at most 100 tables per note are remembered, so `data.json` no longer grows without limit
- Disabling the plugin in settings now removes existing resize handles immediately instead of waiting for the next render

### Fixed
- Drag state (document listeners, drag cursor, text selection) is now fully cleaned up when a drag is cancelled (`pointercancel`), not only when it ends
- `setCssStyles` is now feature-detected with a direct style-assignment fallback, so the declared `minAppVersion: 0.15.0` is accurate on app versions that predate the helper

### Changed
- `versions.json` now uses the official flat format (`plugin version → minimum app version`); the previous nested form was ignored by the updater, which fell back to the manifest value

## [1.0.3] - 2026-10-04

### Added
- Declarative settings API (`getSettingDefinitions`) so plugin settings appear in Obsidian's built-in settings search (Obsidian 1.13.0+); the imperative settings UI is kept for older versions
- README: comparison table with similar table plugins

### Changed
- Release workflow now runs `npm ci` and attests build provenance for release assets (GitHub artifact attestations)
- Resize handle is created with Obsidian's `createEl` helper; the fire-and-forget persistence write after a drag is now explicitly marked as ignored

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
