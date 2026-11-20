local custom = require("custom")
local border = custom.borders[custom.border]
-- Hover text starts on the line below the cursor, after the top border when the style has one.
local has_top = type(border) == "string" or border[2] ~= ""

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
		views = {
			hover = {
				border = { style = border },
				position = { row = has_top and 2 or 1, col = 2 },
			},
		},
	},
}
