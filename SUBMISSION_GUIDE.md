# Community Plugin Submissions

Thank you for your interest in submitting a plugin to the Obsidian Community Plugins list!

## 📋 Pre-submission Checklist

Before submitting, please ensure:

- [ ] Plugin is functional and tested
- [ ] No major bugs or security issues
- [ ] Code is well-documented
- [ ] README is complete (English)
- [ ] Screenshots are included
- [ ] License file is present
- [ ] Repository is public

## 📝 Submission Steps

### 1. Create GitHub Repository
```bash
# Create new repository on GitHub
# Clone it locally
git clone https://github.com/yourusername/obsidian-table-column-resizer.git
cd obsidian-table-column-resizer

# Add your files
git add .
git commit -m "Initial commit"
git push origin main
```

### 2. Create Release
```bash
# Tag your release
git tag -a 1.0.0 -m "Initial release"
git push origin 1.0.0
```

### 3. Submit to Community Plugins
1. Fork the [obsidianmd/obsidian-releases](https://github.com/obsidianmd/obsidian-releases) repository
2. Add your plugin to the `community-plugins.json` file
3. Create a pull request with the following information:

```json
{
  "id": "table-column-resizer",
  "name": "Table Column Resizer",
  "author": "SOLO Builder",
  "description": "Resize table columns by dragging in preview mode",
  "repo": "solo-builder/obsidian-table-column-resizer",
  "branch": "main",
  "version": "1.0.0"
}
```

### 4. PR Description Template
```markdown
## Plugin Submission: Table Column Resizer

**Plugin ID**: table-column-resizer
**Repository**: https://github.com/solo-builder/obsidian-table-column-resizer

### Description
Allows users to resize table columns by dragging in preview mode, with persistent settings and visual feedback.

### Features
- ✅ Drag to resize table columns
- ✅ Persistent column width settings
- ✅ Visual feedback and smooth animations
- ✅ Theme compatible
- ✅ Customizable min/max/default widths

### Testing
- [ ] Tested on desktop
- [ ] Tested on mobile
- [ ] No console errors
- [ ] No performance issues

### Screenshots
[Add screenshots here]

### Additional Notes
This plugin only works in preview mode for stability.
```

## 🚨 Important Notes

1. **Repository must be public**
2. **Code must be open source**
3. **No malicious code allowed**
4. **Follow Obsidian plugin guidelines**
5. **Be patient - review process takes time**

## 📞 Support

If you have questions:
- Check [Obsidian Plugin Guidelines](https://docs.obsidian.md/Plugins/Releasing/Plugin+guidelines)
- Ask in [Obsidian Discord](https://discord.gg/obsidianmd)
- Review existing plugin submissions

Good luck with your submission! 🎉