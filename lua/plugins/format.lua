local disable_filetypes = { c = true, cpp = true, lua = true, python = true }

return {
	{
		"stevearc/conform.nvim",
		opts = {},
		event = "BufReadPost",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua        = { "lua_ls" },
					python     = { "ruff"},
					css        = { "prettier" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					html       = { "prettier" },
				},
				format_on_save = function(bufnr)
					if disable_filetypes[vim.bo[bufnr].filetype] then
						return
					end
					return {
						timeout_ms = 5000,
						lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
						lsp_format = "fallback",
					}
				end,
			})
		end,
	},
}
