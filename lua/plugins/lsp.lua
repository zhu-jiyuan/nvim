local custom = require("custom")

local LspSetting = require("lsp_setting")

local on_attach = LspSetting.lsp_on_attach
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim",  opts = {} },
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"nvimdev/lspsaga.nvim",
		},
		-- opts = {
		-- 	autoformat = false,
		-- },
		config = function()
			-- vim.diagnostic.config({
			-- 	signs = {
			-- 		text = {
			-- 			[vim.diagnostic.severity.ERROR] = custom.symbol.error,
			-- 			[vim.diagnostic.severity.WARN] = custom.symbol.warn,
			-- 			[vim.diagnostic.severity.INFO] = custom.symbol.info,
			-- 			[vim.diagnostic.severity.HINT] = custom.symbol.hint,
			-- 		},
			-- 	},
			-- })
			vim.diagnostic.config({
				virtual_text = false
			})
			require("lspsaga").setup({
				diagnostic = {
					diagnostic_only_current = true,
					border_follow = false
				},
				outline = {
					keys = {
						quit = "<C-c>",
						toggle_or_jump = "<cr>",
					},
				},
				finder = {
					keys = {
						quit = "<C-c>",
						edit = "<C-o>",
						toggle_or_open = "<cr>",
					},
				},
				definition = {
					keys = {
						edit = "<C-o>",
						vsplit = "<C-v>",
					},
				},
				code_action = {
					keys = {
						quit = "<C-c>",
					},
				},
				ui = {
					code_action = "🔅",
				},
				lightbulb = {
					enable = false,
					sign = true,
					debounce = 10,
					sign_priority = 1,
					virtual_text = false,
					-- enable_in_insert = true,
				},
				hover = {
					keys = {
						quit = "<C-c>",
					},
				},
				rename = {
					keys = {
						quit = "<C-c>",
					},
					in_select = false,
				},
			})
			require("neoconf").setup({
				-- override any of the default settings here
			})
			require("neodev").setup()
			-- require "lspsaga".setup()

			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = LspSetting.ensure_installed_list
			})
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- for server, server_config in pairs(server_list) do
			-- 	require("lspconfig")[server].setup(vim.tbl_deep_extend("keep", {
			-- 		capabilities = capabilities,
			-- 		on_attach = on_attach,
			-- 		settings = server_list[server],
			-- 		filetypes = (server_list[server] or {}).filetypes,
			-- 	}, server_config))
			-- end
		end,
	},
}
