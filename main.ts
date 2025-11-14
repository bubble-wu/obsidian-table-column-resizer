import { Plugin, MarkdownPostProcessorContext, PluginSettingTab, Setting, App } from 'obsidian';

interface PluginSettings {
	minColumnWidth: number;
	maxColumnWidth: number;
	defaultColumnWidth: number;
	enableInPreviewMode: boolean;
}

const DEFAULT_SETTINGS: PluginSettings = {
	minColumnWidth: 50,
	maxColumnWidth: 500,
	defaultColumnWidth: 150,
	enableInPreviewMode: true
};

export default class TableColumnResizerPlugin extends Plugin {
	settings: PluginSettings;
	isResizing: boolean = false;
	currentTable: HTMLElement | null = null;
	currentColumn: number = -1;
	startX: number = 0;
	startWidth: number = 0;

	async onload() {
		await this.loadSettings();
		console.log('加载表格列宽调整插件 (预览模式)');

		// 只支持预览模式
		if (this.settings.enableInPreviewMode) {
			this.registerMarkdownPostProcessor((element, context) => {
				this.processTablesInPreview(element, context);
			});
		}

		// 添加设置面板
		this.addSettingTab(new TableColumnResizerSettingTab(this.app, this));
	}

	// 预览模式处理表格
	processTablesInPreview(element: HTMLElement, context: MarkdownPostProcessorContext) {
		const tables = element.querySelectorAll('table');
		tables.forEach((table, index) => {
			this.makeTableResizable(table as HTMLElement, index, context.sourcePath);
		});
	}

	// 使表格可调整列宽
	makeTableResizable(table: HTMLElement, tableIndex: number, filePath: string) {
		if (table.hasAttribute('data-resizable')) return;
		table.setAttribute('data-resizable', 'true');

		// 恢复保存的列宽
		this.applySavedColumnWidths(table);

		const headers = table.querySelectorAll('th, td');
		headers.forEach((header, columnIndex) => {
			if (columnIndex === headers.length - 1) return;

			const headerEl = header as HTMLElement;
			const resizer = document.createElement('div');
			resizer.className = 'table-column-resizer';
			resizer.style.cssText = `
				position: absolute;
				right: -3px;
				top: 0;
				width: 6px;
				height: 100%;
				cursor: col-resize;
				z-index: 10;
				opacity: 0;
				transition: opacity 0.2s;
			`;

			headerEl.style.position = 'relative';
			headerEl.appendChild(resizer);

			// 鼠标悬停显示拖拽手柄
			headerEl.addEventListener('mouseenter', () => {
				resizer.style.opacity = '1';
			});

			headerEl.addEventListener('mouseleave', () => {
				if (!this.isResizing) resizer.style.opacity = '0';
			});

			// 拖拽事件
			resizer.addEventListener('mousedown', (e) => {
				e.preventDefault();
				this.startResize(e, table, columnIndex);
			});
		});
	}

	startResize(e: MouseEvent, table: HTMLElement, columnIndex: number) {
		this.isResizing = true;
		this.currentTable = table;
		this.currentColumn = columnIndex;
		this.startX = e.clientX;

		const rows = table.querySelectorAll('tr');
		const firstCell = rows[0].children[columnIndex] as HTMLElement;
		this.startWidth = firstCell.offsetWidth;

		// 添加拖拽样式
		table.setAttribute('data-resizing', 'true');
		document.body.classList.add('table-resizing');

		document.addEventListener('mousemove', this.handleMouseMove);
		document.addEventListener('mouseup', this.handleMouseUp);
	}

	handleMouseMove = (e: MouseEvent) => {
		if (!this.isResizing || !this.currentTable) return;

		const deltaX = e.clientX - this.startX;
		let newWidth = this.startWidth + deltaX;

		// 限制宽度范围
		newWidth = Math.max(this.settings.minColumnWidth, 
						Math.min(newWidth, this.settings.maxColumnWidth));

		// 调整整列宽度
		const rows = this.currentTable.querySelectorAll('tr');
		rows.forEach(row => {
			const cell = row.children[this.currentColumn] as HTMLElement;
			if (cell && cell.style) {
				cell.style.width = newWidth + 'px';
				cell.style.minWidth = newWidth + 'px';
				cell.style.maxWidth = newWidth + 'px';
			}
		});
	}

	handleMouseUp = () => {
		if (!this.isResizing) return;

		this.isResizing = false;
		document.removeEventListener('mousemove', this.handleMouseMove);
		document.removeEventListener('mouseup', this.handleMouseUp);

		// 移除样式
		if (this.currentTable) {
			this.currentTable.removeAttribute('data-resizing');
			// 保存列宽设置
			this.saveTableColumnWidths(this.currentTable);
		}
		document.body.classList.remove('table-resizing');

		this.currentTable = null;
		this.currentColumn = -1;
	}

	// 保存表格列宽设置
	saveTableColumnWidths(table: HTMLElement) {
		const tableId = this.getTableId(table);
		const rows = table.querySelectorAll('tr');
		if (rows.length === 0) return;

		const columnWidths: { [key: number]: number } = {};
		const firstRow = rows[0];
		
		for (let i = 0; i < firstRow.children.length; i++) {
			const cell = firstRow.children[i] as HTMLElement;
			if (cell.style.width) {
				columnWidths[i] = parseInt(cell.style.width);
			}
		}

		// 保存到插件数据
		const savedData = this.loadDataSync();
		savedData[tableId] = columnWidths;
		this.saveData(savedData);
	}

	// 恢复保存的列宽设置
	applySavedColumnWidths(table: HTMLElement) {
		const tableId = this.getTableId(table);
		const savedData = this.loadDataSync();
		const columnWidths = savedData[tableId];

		if (!columnWidths) return;

		Object.entries(columnWidths).forEach(([columnIndex, width]) => {
			const rows = table.querySelectorAll('tr');
			rows.forEach(row => {
				const cell = row.children[parseInt(columnIndex)] as HTMLElement;
				if (cell && cell.style) {
					cell.style.width = width + 'px';
					cell.style.minWidth = width + 'px';
					cell.style.maxWidth = width + 'px';
				}
			});
		});
	}

	// 生成表格唯一ID
	getTableId(table: HTMLElement): string {
		// 基于表格内容和位置生成ID
		const content = table.textContent || '';
		const truncatedContent = content.substring(0, 50).replace(/\s/g, '');
		const parent = table.parentElement;
		const index = parent ? Array.from(parent.children).indexOf(table) : 0;
		return `table_${truncatedContent}_${index}`;
	}

	loadDataSync(): any {
		return this.loadData() || {};
	}

	async loadSettings() {
		this.settings = Object.assign({}, DEFAULT_SETTINGS, await this.loadData());
	}

	async saveSettings() {
		await this.saveData(this.settings);
	}

	onunload() {
		console.log('卸载表格列宽调整插件');
	}
}

class TableColumnResizerSettingTab extends PluginSettingTab {
	plugin: TableColumnResizerPlugin;

	constructor(app: App, plugin: TableColumnResizerPlugin) {
		super(app, plugin);
		this.plugin = plugin;
	}

	display(): void {
		const { containerEl } = this;
		containerEl.empty();

		containerEl.createEl('h2', { text: '表格列宽调整设置' });

		// 最小列宽设置
		new Setting(containerEl)
			.setName('最小列宽')
			.setDesc('列的最小宽度（像素）')
			.addSlider(slider => slider
				.setLimits(30, 100, 10)
				.setValue(this.plugin.settings.minColumnWidth)
				.setDynamicTooltip()
				.onChange(async (value) => {
					this.plugin.settings.minColumnWidth = value;
					await this.plugin.saveSettings();
				}));

		// 最大列宽设置
		new Setting(containerEl)
			.setName('最大列宽')
			.setDesc('列的最大宽度（像素）')
			.addSlider(slider => slider
				.setLimits(200, 800, 50)
				.setValue(this.plugin.settings.maxColumnWidth)
				.setDynamicTooltip()
				.onChange(async (value) => {
					this.plugin.settings.maxColumnWidth = value;
					await this.plugin.saveSettings();
				}));

		// 默认列宽设置
		new Setting(containerEl)
			.setName('默认列宽')
			.setDesc('新表格的默认列宽（像素）')
			.addSlider(slider => slider
				.setLimits(80, 300, 20)
				.setValue(this.plugin.settings.defaultColumnWidth)
				.setDynamicTooltip()
				.onChange(async (value) => {
					this.plugin.settings.defaultColumnWidth = value;
					await this.plugin.saveSettings();
				}));
	}
}