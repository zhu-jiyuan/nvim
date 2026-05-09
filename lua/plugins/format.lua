local format_on_save_filetypes = {
	html = true,
	typescript = true,
	typescriptreact = true,
	-- add filetypes here to opt them into async format-on-save
}

return {
	{
		"stevearc/conform.nvim",
		event = "BufReadPost",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua             = { "lua_ls" },
					python          = { "ruff" },
					css             = { "biome" },
					javascript      = { "biome" },
					javascriptreact = { "biome" },
					typescript      = { "biome" },
					typescriptreact = { "biome" },
					json            = { "biome" },
					jsonc           = { "biome" },
					html            = { "prettier" },
				},
				format_after_save = function(bufnr)
					if not format_on_save_filetypes[vim.bo[bufnr].filetype] then
						return
					end
					return {
						lsp_format = "fallback",
						timeout_ms = 5000,
					}
				end,
			})
		end,
	},
}
