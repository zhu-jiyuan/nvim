local custom = require("custom")

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			-- blink.cmp registers its completion capabilities on load; that has to happen before a server starts.
			"blink_cmp",
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				float = {
					focusable = false,
					style = "minimal",
					border = custom.borders[custom.border],
					source = true,
					header = "",
					prefix = "",
				},
			})

			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			require("mason-lspconfig").setup({})
		end,
	},
}
