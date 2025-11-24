
local M = {}
local option = vim.opt
local buffer = vim.b
local global = vim.g

M.option = option
M.buffer = buffer
M.global = global

option.encoding = "UTF-8"
buffer.fileencoding = "UTF-8"

option.tabstop = 4
option.softtabstop = 4
option.shiftround = true

option.undodir = os.getenv("HOME") .. "/.vim/undodir"
option.undofile = true

option.number = true

option.relativenumber = true

option.clipboard = "unnamedplus"

option.inccommand = "split"

option.cursorline = true

option.signcolumn = "yes"

option.colorcolumn = "80"
option.autoread = true
option.title = true

option.shiftwidth = 4

option.autoindent = true
option.smartindent = true

option.ignorecase = true
option.smartcase = true

option.hlsearch = true
option.incsearch = true

option.cmdheight = 1

option.backup = false
option.writebackup = false
option.swapfile = false
option.wrap = false

option.updatetime = 50
option.timeoutlen = 500
option.splitbelow = true
option.splitright = true

option.termguicolors = true

option.list = false
option.listchars = "space:·,tab:>-"
option.wildmenu = true

global.mapleader = " "
global.maplocalleader = " "

global.grepprg = "rg --vimgrep --smart-case"
global.grepformat = "%f:%l:%c:%m"
vim.api.nvim_command('cnoreabbrev <expr> grep (getcmdtype() == ":" && getcmdline() =~# "^grep") ? "silent grep" : "grep"')

option.guicursor = ""

return M

