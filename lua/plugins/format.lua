local disable_filetypes = { c = true, cpp = true, lua = true }

return {
	{
		"stevearc/conform.nvim",
		opts = {},
		event = "BufReadPost",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua        = { "lua_ls" },
					-- Conform will run multiple formatters sequentially
					python     = { "isort", "black" },
					-- Use a sub-list to run only the first available formatter
					css        = { "prettier" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					html       = { "prettier" },
					["*"]      = { "prettier", "codespell" },
				},
				format_on_save = function(bufnr)
					if disable_filetypes[vim.bo[bufnr].filetype] then
						return
					end
					return {
						-- async = true,
						timeout_ms = 100,
						lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
					}
				end,
			})
		end,
	},
}
