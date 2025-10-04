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
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.defer_fn(function()
			option.foldexpr = "nvim_treesitter#foldexpr()"
			option.foldmethod = "expr"
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
  end,
})

