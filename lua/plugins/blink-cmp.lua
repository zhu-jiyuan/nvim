local custom = require("custom")
local border = custom.borders[custom.border]

return {
	{
		"saghen/blink.cmp",
		name = "blink_cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"rafamadriz/friendly-snippets",
		},

		-- A release tag downloads the pre-built fuzzy matcher binary.
		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",

				["<C-s>"] = {
					function(cmp)
						cmp.show({ providers = { "snippets" } })
					end,
				},
				["<C-Enter>"] = { "show", "show_documentation", "hide_documentation" },
			},
			signature = { enabled = true, window = { border = border } },

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					window = { border = border },
				},
				accept = { auto_brackets = { enabled = true } },
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				menu = {
					border = border,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
						},
					},
				},
			},

			snippets = { preset = "default" },
			cmdline = {
				enabled = true,
				keymap = {
					preset = "inherit",
					["<Tab>"] = { "show", "accept" },
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
				completion = {
					menu = {
						auto_show = function()
							return vim.fn.getcmdtype() == ":"
						end,
					},
				},
			},

			sources = {
				default = { "lsp", "buffer", "snippets", "path" },
				per_filetype = {
					sql = { inherit_defaults = true, "dadbod" },
					mysql = { inherit_defaults = true, "dadbod" },
					plsql = { inherit_defaults = true, "dadbod" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					cmdline = {
						min_keyword_length = function(ctx)
							-- when typing a command, only show when the keyword is 3 characters or longer
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
