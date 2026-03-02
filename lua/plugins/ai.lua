return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
		},
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					auto_refresh = true,
					debounce = 75,
					keymap = {
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						accept = "<C-y>"
					},
				},
			})
			vim.g.copilot_nes_debounce = 500
		end,
	},
}
