-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		require("conform").format({ bufnr = args.buf })
-- 	end,
-- })
--
-- highlight on yank
local setting = require "settings"
local option = setting.option

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.defer_fn(function()
			-- option.foldcolumn = "1"
			-- opt.foldtext = ""

			-- option.foldnestmax = 3
			option.foldlevel = 99
			option.foldlevelstart = 99
		end, 150)
	end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*",
	callback = function(args)
		local bufnr = args.buf
		local lsp = require("lsp_setting")
		lsp.lsp_on_attach(nil, bufnr)
		local ok = pcall(require, "copilot")
		if ok then
			if vim.fn.exists(":Copilot") == 2 then
				vim.cmd("silent! Copilot enable")
			end
		end
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		-- Enable LSP-based folding if supported.
		if client:supports_method('textDocument/foldingRange', bufnr) then
			vim.o.foldmethod = 'expr'
			vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
			vim.o.foldtext = 'v:lua.vim.lsp.foldtext()'
		end
	end,
})


-- https://github.com/neovim/neovim/issues/28692
vim.api.nvim_create_autocmd("FileType", {
	desc = 'Enable treesitter-based features for supported filetypes',
	callback = function(args)
		local bufnr = args.buf
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if lang and vim.treesitter.language.add(lang) then
			-- Highlighting
			vim.treesitter.start(bufnr, lang)
			-- Folds
			vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.wo[0][0].foldmethod = 'expr'
			-- vim.opt.foldmethod = "expr"
			-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			-- Indentation
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			-- vim.print("Treesitter enabled for " .. filetype .. " (" .. lang .. ")")
		end
	end,
})
