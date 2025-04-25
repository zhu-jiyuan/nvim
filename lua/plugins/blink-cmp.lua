return {
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = {
			'rafamadriz/friendly-snippets',
			{
				'L3MON4D3/LuaSnip',
				dependencies = { "rafamadriz/friendly-snippets" },
				version = 'v2.*',
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
				end
			}
		},

		-- use a release tag to download pre-built binaries
		version = '1.*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = 'enter',

				['<C-s>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
				['<C-Enter>'] = { 'show', 'show_documentation', 'hide_documentation' },
			},
			signature = { enabled = true },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono'
			},

			-- (Default) Only show the documentation popup when manually triggered
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
							-- { "source_name", gap = 1 }
						},
					}
				},
			},

			-- snippets
			snippets = { preset = 'luasnip' },
			cmdline = {
				enabled = true,
				keymap = {
					-- recommended, as the default keymap will only show and select the next item
					['<Tab>'] = { 'show', 'accept' },
					['<CR'] = {'accept_and_enter', 'fallback'}
				},

				completion = {
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ':'

							-- enable for inputs as well, with:
							-- or vim.fn.getcmdtype() == '@'
						end,
					},
				}
			},


			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { 'lsp', 'buffer', 'snippets', 'path' },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	}
}
