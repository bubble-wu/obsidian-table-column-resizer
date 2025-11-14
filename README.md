# Table Column Resizer for Obsidian

An Obsidian plugin that allows you to resize table columns by dragging, making your tables more readable and visually appealing.

**Author**: bubble (wzihua@hotmail.com)
**Version**: 1.0.0

## ✨ Features

- **Drag to Resize**: Click and drag table column borders to adjust width
- **Persistent Settings**: Column widths are saved and restored
- **Preview Mode Only**: Stable implementation that works in preview mode
- **Customizable**: Set minimum, maximum, and default column widths
- **Visual Feedback**: Clear hover and drag indicators
- **Theme Compatible**: Works with all Obsidian themes

## 📸 Screenshots

### Before - Default Table (Plugin Disabled)
![Default Table](./screenshots/before-plugin.svg)
*Standard markdown table with default column widths*

### During - Hover Effect (Plugin Enabled)
![Hover Effect](./screenshots/hover-effect.svg)
*Blue resize handle appears when hovering over column borders*

### After - Customized Widths (After Resizing)
![Customized Widths](./screenshots/after-resizing.svg)
*Table columns resized to custom widths - notice how "Name" column is wider*

## 🚀 Installation

### Manual Installation
1. Download the latest release from [GitHub Releases](https://github.com/solo-builder/obsidian-table-column-resizer/releases)
2. Extract the files to your vault's `.obsidian/plugins/table-column-resizer/` folder
3. Enable the plugin in Obsidian Settings → Community Plugins

### Using Git (Development)
```bash
cd /path/to/your/vault/.obsidian/plugins/
git clone https://github.com/solo-builder/obsidian-table-column-resizer.git
cd obsidian-table-column-resizer
npm install
npm run build
```

## 🛠️ Usage

1. **Create a Table**: Add a Markdown table to your note
   ```markdown
   | Name | Age | City | Description |
   |------|-----|------|-------------|
   | John | 25  | NYC  | Software developer |
   | Jane | 30  | LA   | Product manager |
   ```

2. **Switch to Preview Mode**: Press `Cmd/Ctrl + E` or click the preview button

3. **Resize Columns**: 
   - Hover over any column border
   - Click and drag the red resize handle
   - Release to set the new width

4. **Settings**: 
   - Go to Settings → Table Column Resizer
   - Adjust minimum, maximum, and default column widths

## ⚙️ Settings

| Setting | Default | Description |
|---------|---------|-------------|
| Minimum Column Width | 50px | Smallest allowed column width |
| Maximum Column Width | 500px | Largest allowed column width |
| Default Column Width | 150px | Width for new columns |

## 🎨 Customization

The plugin uses CSS variables for theming:

```css
/* Customize resize handle color */
.table-column-resizer {
    background: linear-gradient(
        to bottom,
        transparent 0%,
        var(--interactive-accent) 20%,
        var(--interactive-accent) 80%,
        transparent 100%
    ) !important;
}
```

## 🔧 Development

### Setup Development Environment
```bash
git clone https://github.com/solo-builder/obsidian-table-column-resizer.git
cd obsidian-table-column-resizer
npm install
```

### Build Plugin
```bash
npm run build
```

### Install for Testing
```bash
# macOS
./install-macos.sh

# Manual: Copy files to your vault's .obsidian/plugins/table-column-resizer/ folder
```

## 🐛 Known Issues

- Only works in **Preview Mode** (not Edit Mode) - This is intentional for stability
- Column widths are saved per table, not globally

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Obsidian team for the amazing platform
- Obsidian community for feedback and support
- Sample plugin template for getting started

## 📞 Support

If you find this plugin helpful, please consider:
- ⭐ Starring the repository
- 🐛 Reporting bugs in Issues
- 💡 Suggesting new features
- 📝 Contributing code improvements

**Contact**: For questions or feedback, email: **wzihua@hotmail.com**

## 🙏 Author

Created by **bubble** - Making Obsidian tables more user-friendly!

---

**Enjoy resizing your tables! 🎉**