# Table Column Resizer for Obsidian

An Obsidian plugin that lets you resize Markdown table columns by dragging their edges — no code blocks, no migration. Your notes stay plain Markdown.

**Author**: [bubble](https://github.com/bubble-wu)
**Version**: 1.0.1

## Features

- **Drag to resize**: grab a column edge in the header row and drag
- **Persistent**: widths are saved per table and restored across restarts
- **Reading view**: works in reading view (Live Preview support is planned)
- **Customizable limits**: set any minimum and maximum column width
- **Theme friendly**: styles are scoped to the resize handle and don't fight your theme

## Installation

### From GitHub Releases (manual)

1. Download `main.js`, `manifest.json`, and `styles.css` from the [latest release](https://github.com/bubble-wu/obsidian-table-column-resizer/releases)
2. Copy them into your vault: `.obsidian/plugins/table-column-resizer/`
3. Enable the plugin in Settings → Community plugins

### Development

```bash
git clone https://github.com/bubble-wu/obsidian-table-column-resizer.git
cd obsidian-table-column-resizer
npm install
npm run build   # outputs main.js
```

## Usage

1. Add a Markdown table to a note:

   ```markdown
   | Name | Age | City | Description |
   |------|-----|------|-------------|
   | John | 25  | NYC  | Software developer |
   | Jane | 30  | LA   | Product manager |
   ```

2. Switch to reading view (`Cmd/Ctrl + E`)
3. Hover a header cell — a vertical handle appears on its right edge. Drag it to resize the column.
4. Widths are saved when you release the mouse, and restored the next time the table is rendered.

## Settings

| Setting | Default | Description |
|---------|---------|-------------|
| Enable column resizing | on | Toggle resizing without disabling the plugin |
| Minimum column width | 50px | Smallest allowed column width |
| Maximum column width | 500px | Largest allowed column width |

Widths are keyed by note path + table content: they survive restarts and edits elsewhere in the note, and reset if the table's content changes.

## Known limitations

- Reading view only — Live Preview is not supported yet (planned)
- Mouse-driven; touch dragging is not supported
- Two byte-identical tables in the same note share their saved widths

## License

MIT — see [LICENSE](LICENSE).
