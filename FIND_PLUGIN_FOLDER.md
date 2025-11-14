# 查找Obsidian插件目录路径

## 方法1：通过Obsidian设置
1. 打开Obsidian设置
2. 点击"关于"或"系统信息"
3. 查看"配置文件夹"路径

## 方法2：常见路径位置

### Windows系统：
```
C:\Users\[你的用户名]\AppData\Roaming\obsidian\obsidian\[你的库名]\.obsidian\plugins\
```

### macOS系统：
```
/Users/[你的用户名]/Library/Application Support/obsidian/obsidian/[你的库名]/.obsidian/plugins/
```

### Linux系统：
```
/home/[你的用户名]/.config/obsidian/obsidian/[你的库名]/.obsidian/plugins/
```

## 方法3：强制创建文件夹

1. 在文件资源管理器中，直接导航到上述路径
2. 手动创建 `table-column-resizer` 文件夹
3. 将插件文件复制进去

## 验证方法

创建文件夹后，立即：
1. 在文件夹内创建一个空文件（如 `test.txt`）
2. 这样文件夹就不是空的了
3. 返回Obsidian，看插件是否能识别

## 备用方案：使用命令行

如果图形界面有问题，可以用命令行：

### Windows (PowerShell):
```powershell
# 找到你的Obsidian库路径，然后执行：
New-Item -ItemType Directory -Path "你的库路径\.obsidian\plugins\table-column-resizer" -Force
Copy-Item "路径\到\你的\插件文件\*" "你的库路径\.obsidian\plugins\table-column-resizer\" -Force
```

### macOS/Linux:
```bash
mkdir -p "你的库路径/.obsidian/plugins/table-column-resizer"
cp "/Users/bytedance/Desktop/Code Base/table-column-resizer/"* "你的库路径/.obsidian/plugins/table-column-resizer/"
```