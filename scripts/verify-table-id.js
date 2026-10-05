const fs = require('fs');

// 旧 1.0.3 构建产物中的 getTableId（照抄 vault main.js 第 170-178 行）
function oldGetTableId(table, sourcePath) {
	const content = table.textContent != null ? table.textContent : '';
	let hash = 5381;
	for (let i = 0; i < content.length; i++) {
		hash = (hash << 5) + hash + content.charCodeAt(i) >>> 0;
	}
	return `${sourcePath}::${hash.toString(36)}`;
}

// 新构建产物中的 getTableId（从 main.js 原文截取，保证和实际发布行为一致）
const newSrc = fs.readFileSync(require('path').join(__dirname, '..', 'main.js'), 'utf8');
const m = newSrc.match(/getTableId\(table, sourcePath\) \{[\s\S]*?\n\t\}/)
	|| newSrc.match(/getTableId\(table, sourcePath\) \{[\s\S]*?\n  \}/);
if (!m) {
	console.log('FAIL: 未能在新 main.js 中定位 getTableId');
	process.exit(1);
}
const newGetTableId = new Function(
	'table',
	'sourcePath',
	m[0].replace(/^getTableId\(table, sourcePath\) \{/, '').replace(/\}$/, '') + '\nreturn `${sourcePath}::${hash.toString(36)}`;'
);

const samples = [
	{ textContent: 'Name|Age\nAlice|30', sourcePath: 'notes/test.md' },
	{ textContent: '中文表格 内容 测试', sourcePath: 'daily/2026-10-05.md' },
	{ textContent: '', sourcePath: 'untitled.md' },
	{ textContent: 'x'.repeat(1000) + '😀 emoji', sourcePath: 'a b/c d.md' },
	{ textContent: 'same content', sourcePath: 'file with ::in name.md' }
];

let ok = true;
for (const s of samples) {
	const a = oldGetTableId(s, s.sourcePath);
	const b = newGetTableId(s, s.sourcePath);
	const mark = a === b ? 'PASS' : 'FAIL';
	if (a !== b) ok = false;
	console.log(mark, JSON.stringify(a), a === b ? '==' : '!=', JSON.stringify(b));
}
console.log(ok ? `\nPASS: 新旧 getTableId 对 ${samples.length} 个样本（含中文/emoji/空内容/特殊路径）输出完全一致，已存列宽不受影响` : '\nFAIL');
process.exit(ok ? 0 : 1);
