return {
	{
		'saghen/blink.cmp',
		name = "blink_cmp",
		dependencies = {
			'rafamadriz/friendly-snippets',
			{
				'L3MON4D3/LuaSnip',
				dependencies = { "rafamadriz/friendly-snippets" },
				version = 'v2.*',
				build = "make install_jsregexp",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
				end
			}
		},

		version = '1.*',
		build = 'cargo build --release',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = 'enter',

				['<C-s>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
				['<C-Enter>'] = { 'show', 'show_documentation', 'hide_documentation' },
			},
			signature = { enabled = true },

			appearance = {
				nerd_font_variant = 'mono'
			},

			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
				accept = { auto_brackets = { enabled = true } },
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
				menu = {
					draw = {
						columns = {
							{ "label",     "label_description", gap = 1 },
							{ "kind_icon", "kind",              gap = 1 },
						},
					}
				},
			},

			snippets = { preset = 'default' },
			cmdline = {
				enabled = true,
				keymap = {
					preset = 'inherit',
					['<Tab>'] = { 'show', 'accept' },
					['<CR>'] = { 'accept_and_enter', 'fallback' }
				},


				completion = {
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ':'

						end,
					},
				}
			},


			sources = {
				default = { 'lsp', 'buffer', 'snippets', 'path' },
				providers = {
					cmdline = {
						min_keyword_length = function(ctx)
							if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 3 end
							return 0
						end
					}
				}
			},

			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	}
}
