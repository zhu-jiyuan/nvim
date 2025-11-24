local disable_filetype_tbl = {
	html = true,
	json = true,
}
return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vimdoc",
					"json",
					"python",
					"markdown",
					"bash",
					"go",
				},
				ignore_install = {},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						if disable_filetype_tbl[lang] then
							return true
						end
						local max_filesize = 100 * 1024
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							vim.notify(
								"File larger than 100KB treesitter disabled for performance",
								vim.log.levels.WARN,
								{title = "Treesitter"}
							)
							return true
						end
					end,
					additional_vim_regex_highlighting = { "markdown" },
				},
				indent = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
						},
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							[']a'] = { query = '@parameter.outer', desc = 'Next argument start' },
							[']f'] = { query = '@function.outer', desc = 'Next function start' },
							[']r'] = { query = '@function.outer', desc = 'Next return start' },
							[']c'] = { query = '@class.outer', desc = 'Next class start' },
							[']j'] = { query = '@conditional.outer', desc = 'Next judge start' },
							[']l'] = { query = '@loop.outer', desc = 'Next loop start' },
						},
						goto_next_end = {
							[']A'] = { query = '@parameter.outer', desc = 'Next argument end' },
							[']F'] = { query = '@function.outer', desc = 'Next function end' },
							[']R'] = { query = '@function.outer', desc = 'Next return end' },
							[']C'] = { query = '@class.outer', desc = 'Next class end' },
							[']J'] = { query = '@conditional.outer', desc = 'Next judge end' },
							[']L'] = { query = '@loop.outer', desc = 'Next loop end' },
						},
						goto_previous_start = {
							['[a'] = { query = '@parameter.outer', desc = 'Previous argument start' },
							['[f'] = { query = '@function.outer', desc = 'Previous function start' },
							['[r'] = { query = '@function.outer', desc = 'Previous return start' },
							['[c'] = { query = '@class.outer', desc = 'Previous class start' },
							['[j'] = { query = '@conditional.outer', desc = 'Previous judge start' },
							['[l'] = { query = '@loop.outer', desc = 'Previous loop start' },
						},
						goto_previous_end = {
							['[A'] = { query = '@parameter.outer', desc = 'Previous argument end' },
							['[F'] = { query = '@function.outer', desc = 'Previous function end' },
							['[R'] = { query = '@function.outer', desc = 'Previous return end' },
							['[C'] = { query = '@class.outer', desc = 'Previous class end' },
							['[J'] = { query = '@conditional.outer', desc = 'Previous judge end' },
							['[L'] = { query = '@loop.outer', desc = 'Previous loop end' },
						},
					}
				},
			})

			require("treesitter-context").setup({
				enable = true,
				max_lines = 2,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 10,
				trim_scope = "outer",
				mode = "topline",
				separator = nil,
				zindex = 10,
				on_attach = nil,
			})
		end,
	},
}
