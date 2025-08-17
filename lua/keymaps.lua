local map = vim.keymap.set
local Runcode = require("runcode")
local Helper = require("helper")

-- opt args
local opt = { noremap = true, silent = true }

-- setting
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- ESC
map("i", "<C-c>", "<ESC>", opt)

map("n", "<Esc>", "<cmd>noh<CR>")

-- map('i', '<CAPSLOCK>', '<ESC>', opt)
map("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
map("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")


--- save
map("n", " ", "<NOP>", opt)

-- nvim-tree
map("n", "<leader>e", ":Oil<CR>", opt)

-- run code
map("n", "<F5>", Runcode.runcode, opt)

-- change window wrap
map("n", "<M-z>", Helper.change_window_wrap, opt)

-- set quickfix next/prev
map("n", "[q", ":prev<CR>", opt)
map("n", "]q", ":cnext<CR>", opt)

map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>d", "\"_d")
-- telescope
-- see plugins/telescope.lua
-- map('n', '<leader>ff', ':Telescope find_files<CR>', opt)
-- map('n', '<leader>fg', ':Telescope live_grep<CR>', opt)
-- map('n', '<leader>fb', ':Telescope buffers<CR>', opt)
-- map('n', '<leader>fh', ':Telescope help_tags<CR>', opt)


-- emacs insert mode
map("i", "<C-a>", "<Home>", opt)
map('c', '<C-a>', '<Home>', {silent = false, noremap = true})
-- vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', opt)
-- vim.cmd([[cnoremap <C-a> <Home>]])

map("i", "<C-e>", "<End>", opt)

map({"i", "c"}, "<C-f>", "<Right>", opt)
map({"i", "c"}, "<C-b>", "<Left>", opt)
map({"i", "c"}, "<C-n>", "<Down>", opt)
map({"i", "c"}, "<C-p>", "<Up>", opt)
map({"i", "c"}, "<C-d>", "<Del>", opt)
map({"i", "c"}, "<C-h>", "<BS>", opt)
