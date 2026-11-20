return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = {
			{
				"copilotlsp-nvim/copilot-lsp",
				init = function()
					vim.g.copilot_nes_debounce = 500
				end,
			},
		},
		opts = {
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
					accept = "<C-y>",
				},
			},
			nes = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept_and_goto = "<Tab>",
					accept = false,
					dismiss = "<Esc>",
				},
			},
		},
	},
}
