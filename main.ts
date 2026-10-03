import { Plugin, MarkdownPostProcessorContext, PluginSettingTab, Setting } from 'obsidian';

interface PluginSettings {
	enabled: boolean;
	minColumnWidth: number;
	maxColumnWidth: number;
}

const DEFAULT_SETTINGS: PluginSettings = {
	enabled: true,
	minColumnWidth: 50,
	maxColumnWidth: 500,
};

/** Saved column widths, keyed by a stable per-table id. */
interface SavedTableWidths {
	[tableId: string]: { [columnIndex: number]: number };
}

interface PluginData {
	settings?: Partial<PluginSettings>;
	tableWidths?: SavedTableWidths;
}

export default class TableColumnResizerPlugin extends Plugin {
	settings: PluginSettings;
	tableWidths: SavedTableWidths = {};

	private isResizing = false;
	private currentTable: HTMLTableElement | null = null;
	private currentSourcePath = '';
	private currentColumn = -1;
	private startX = 0;
	private startWidth = 0;

	async onload() {
		const raw: unknown = await this.loadData();
		const data = (raw ?? {}) as PluginData;
		this.settings = Object.assign({}, DEFAULT_SETTINGS, data.settings ?? {});
		this.tableWidths = data.tableWidths ?? {};

		this.registerMarkdownPostProcessor((element, context) => {
			this.processTables(element, context);
		});

		this.addSettingTab(new TableColumnResizerSettingTab(this.app, this));
	}

	onunload() {
		// Clean up drag state in case the plugin is disabled mid-drag.
		document.removeEventListener('mousemove', this.handleMouseMove);
		document.removeEventListener('mouseup', this.handleMouseUp);
		document.body.classList.remove('table-resizing');
	}

	processTables(element: HTMLElement, context: MarkdownPostProcessorContext) {
		if (!this.settings.enabled) return;
		element.querySelectorAll<HTMLTableElement>('table').forEach((table) => {
			this.makeTableResizable(table, context.sourcePath);
		});
	}

	makeTableResizable(table: HTMLTableElement, sourcePath: string) {
		if (table.hasAttribute('data-resizable')) return;
		table.setAttribute('data-resizable', 'true');

		this.applySavedWidths(table, sourcePath);

		const headerRow = table.rows[0];
		if (!headerRow) return;

		// Attach one handle per header cell (except the last column, whose
		// right edge is the table edge).
		Array.from(headerRow.cells).forEach((cell) => {
			if (cell.cellIndex === headerRow.cells.length - 1) return;

			const handle = createEl('div', { cls: 'table-column-resizer' });
			cell.appendChild(handle);

			handle.addEventListener('mousedown', (e) => {
				e.preventDefault();
				this.startResize(e, table, cell.cellIndex, sourcePath);
			});
		});
	}

	applySavedWidths(table: HTMLTableElement, sourcePath: string) {
		const widths = this.tableWidths[this.getTableId(table, sourcePath)];
		if (!widths) return;

		table.setCssStyles({ tableLayout: 'fixed' });
		Object.entries(widths).forEach(([columnIndex, width]) => {
			this.setColumnWidth(table, Number.parseInt(columnIndex, 10), width);
		});
	}

	startResize(e: MouseEvent, table: HTMLTableElement, columnIndex: number, sourcePath: string) {
		this.isResizing = true;
		this.currentTable = table;
		this.currentSourcePath = sourcePath;
		this.currentColumn = columnIndex;
		this.startX = e.clientX;

		const headerCell = table.rows[0]?.cells[columnIndex];
		this.startWidth = headerCell ? headerCell.getBoundingClientRect().width : this.settings.minColumnWidth;

		// Fixed layout makes the browser respect the exact widths we set.
		table.setCssStyles({ tableLayout: 'fixed' });
		table.setAttribute('data-resizing', 'true');
		document.body.classList.add('table-resizing');

		document.addEventListener('mousemove', this.handleMouseMove);
		document.addEventListener('mouseup', this.handleMouseUp);
	}

	handleMouseMove = (e: MouseEvent) => {
		if (!this.isResizing || !this.currentTable) return;

		const deltaX = e.clientX - this.startX;
		const newWidth = Math.max(
			this.settings.minColumnWidth,
			Math.min(this.startWidth + deltaX, this.settings.maxColumnWidth)
		);

		this.setColumnWidth(this.currentTable, this.currentColumn, newWidth);
	};

	handleMouseUp = async () => {
		if (!this.isResizing) return;
		this.isResizing = false;

		document.removeEventListener('mousemove', this.handleMouseMove);
		document.removeEventListener('mouseup', this.handleMouseUp);
		document.body.classList.remove('table-resizing');

		if (this.currentTable) {
			this.currentTable.removeAttribute('data-resizing');
			await this.saveWidths(this.currentTable, this.currentSourcePath);
		}

		this.currentTable = null;
		this.currentSourcePath = '';
		this.currentColumn = -1;
	};

	setColumnWidth(table: HTMLTableElement, columnIndex: number, width: number) {
		const px = `${width}px`;
		// row.cells is indexed by table column slot, so rows with a
		// different number of cells (or spans) stay aligned correctly.
		Array.from(table.rows).forEach((row) => {
			const cell = row.cells[columnIndex];
			if (cell) {
				cell.setCssStyles({ width: px, minWidth: px, maxWidth: px });
			}
		});
	}

	async saveWidths(table: HTMLTableElement, sourcePath: string) {
		const tableId = this.getTableId(table, sourcePath);
		const headerRow = table.rows[0];
		if (!headerRow) return;

		const widths: { [columnIndex: number]: number } = {};
		Array.from(headerRow.cells).forEach((cell) => {
			if (cell.style.width) {
				widths[cell.cellIndex] = Number.parseFloat(cell.style.width);
			}
		});

		if (Object.keys(widths).length === 0) {
			delete this.tableWidths[tableId];
		} else {
			this.tableWidths[tableId] = widths;
		}

		await this.saveData({ settings: this.settings, tableWidths: this.tableWidths });
	}

	/**
	 * Stable id: source path + hash of the table's text content.
	 * Widths survive restarts and edits elsewhere in the note; they reset
	 * when the table's own content changes.
	 */
	getTableId(table: HTMLTableElement, sourcePath: string): string {
		const content = table.textContent ?? '';
		let hash = 5381;
		for (let i = 0; i < content.length; i++) {
			hash = ((hash << 5) + hash + content.charCodeAt(i)) >>> 0;
		}
		return `${sourcePath}::${hash.toString(36)}`;
	}

	async saveSettings() {
		await this.saveData({ settings: this.settings, tableWidths: this.tableWidths });
	}
}

class TableColumnResizerSettingTab extends PluginSettingTab {
	plugin: TableColumnResizerPlugin;

	display(): void {
		const { containerEl } = this;
		containerEl.empty();

		new Setting(containerEl)
			.setName('Enable column resizing')
			.setDesc('Drag column edges to resize tables in reading view.')
			.addToggle((toggle) =>
				toggle.setValue(this.plugin.settings.enabled).onChange(async (value) => {
					this.plugin.settings.enabled = value;
					await this.plugin.saveSettings();
				})
			);

		new Setting(containerEl)
			.setName('Minimum column width')
			.setDesc('Smallest allowed column width, in pixels.')
			.addText((text) =>
				text
					.setValue(String(this.plugin.settings.minColumnWidth))
					.onChange(async (value) => {
						const parsed = Number.parseInt(value, 10);
						if (!Number.isNaN(parsed) && parsed > 0) {
							this.plugin.settings.minColumnWidth = parsed;
							if (this.plugin.settings.maxColumnWidth < parsed) {
								this.plugin.settings.maxColumnWidth = parsed;
							}
							await this.plugin.saveSettings();
							this.display();
						}
					})
			);

		new Setting(containerEl)
			.setName('Maximum column width')
			.setDesc('Largest allowed column width, in pixels.')
			.addText((text) =>
				text
					.setValue(String(this.plugin.settings.maxColumnWidth))
					.onChange(async (value) => {
						const parsed = Number.parseInt(value, 10);
						if (!Number.isNaN(parsed) && parsed > 0) {
							this.plugin.settings.maxColumnWidth = parsed;
							if (this.plugin.settings.minColumnWidth > parsed) {
								this.plugin.settings.minColumnWidth = parsed;
							}
							await this.plugin.saveSettings();
							this.display();
						}
					})
			);
	}
}
