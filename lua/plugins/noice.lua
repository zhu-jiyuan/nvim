return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				enabled = true,
			},
			signature = {
				enabled = false,
			},
		},
		cmdline = { enabled = false },
		messages = { enabled = false },
		notify = { enabled = false },
		presets = {
			lsp_doc_border = true,
		},
	},
}
