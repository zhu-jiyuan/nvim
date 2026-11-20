local option = vim.opt
local global = vim.g

-- tab设置为4个空格
option.tabstop = 4
option.softtabstop = 4
option.shiftround = true

-- >> << 时移动长度
option.shiftwidth = 4

-- 新行对齐当前行
option.smartindent = true

option.undodir = os.getenv("HOME") .. "/.vim/undodir"
option.undofile = true

-- 显示行号
option.number = true

-- 使用相对行号
option.relativenumber = true

-- 剪切板设置
option.clipboard = "unnamedplus"

-- Preview substitutions live, as you type!
option.inccommand = "split"

-- 高亮所在行
option.cursorline = true

-- 显示左侧图标指示列
option.signcolumn = "yes"

-- 右侧参考线
option.colorcolumn = "80"

option.title = true

-- 搜索大小写不敏感，除非包含大写
option.ignorecase = true
option.smartcase = true

-- 禁止创建备份文件
option.writebackup = false
option.swapfile = false

-- 换行显示
option.wrap = false

-- smaller updatetime
option.updatetime = 50
option.timeoutlen = 500
option.splitbelow = true
option.splitright = true

option.termguicolors = true

-- 不可见字符的显示，这里只把空格显示为一个点
option.listchars = "space:·,tab:>-"

-- 代码折叠
option.foldlevel = 99
option.foldlevelstart = 99

-- Leader键
global.mapleader = " "
global.maplocalleader = " "

-- vimgrep
option.grepprg = "rg --vimgrep --smart-case"
option.grepformat = "%f:%l:%c:%m"
-- 将 grep 替换为静默模式
vim.api.nvim_command(
	'cnoreabbrev <expr> grep (getcmdtype() == ":" && getcmdline() =~# "^grep") ? "silent grep" : "grep"'
)
