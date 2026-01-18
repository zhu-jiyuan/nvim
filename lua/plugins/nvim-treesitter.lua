return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		event = 'VeryLazy',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			local ts = require('nvim-treesitter')
			ts.install({
				"bash",
				"c",
				"cpp",
				"comment",
				"css",
				"diff",
				"dockerfile",
				"elixir",
				"git_config",
				"gitcommit",
				"gitignore",
				"go",
				"groovy",
				"html",
				"http",
				"helm",
				"java",
				"javascript",
				"json",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"nginx",
				"python",
				"regex",
				"rst",
				"rust",
				"scss",
				"sql",
				"ssh_config",
				"terraform",
				"tmux",
				"toml",
				"tsx",
				"typescript",
				"typst",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
				"zsh"
			})
			vim.treesitter.language.register("groovy", {"jenkinsfile", "Jenkinsfile"})
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = { 'nvim-treesitter/nvim-treesitter', branch = 'main' },
		event = 'VeryLazy',
		branch = 'main',
		config = function()
			require('nvim-treesitter-textobjects').setup {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						-- ["ac"] = "@class.outer",
						-- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						-- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = true,
				},
				move = {
					enable = true,
					set_jumps = true,
				}
			}
			local mapset = vim.keymap.set
			local move = require('nvim-treesitter-textobjects.move')
			mapset({ "n", "x", "o" }, "]a", function()
				move.goto_next_start({ '@parameter.outer' })
			end)
			mapset({ "n", "x", "o" }, "[a", function()
				move.goto_previous_start({ '@parameter.outer' })
			end)

			mapset({ "n", "x", "o" }, "]f", function()
				move.goto_next_start({ '@function.outer' })
			end)
			mapset({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start({ '@function.outer' })
			end)

			mapset({ "n", "x", "o" }, "]r", function()
				move.goto_next_start({ '@function.outer' })
			end)
			mapset({ "n", "x", "o" }, "[r", function()
				move.goto_previous_start({ '@function.outer' })
			end)

			mapset({ "n", "x", "o" }, "]c", function()
				move.goto_next_start({ '@class.outer' })
			end)
			mapset({ "n", "x", "o" }, "[c", function()
				move.goto_previous_start({ '@class.outer' })
			end)

			mapset({ "n", "x", "o" }, "]j", function()
				move.goto_next_start({ '@conditional.outer' })
			end)
			mapset({ "n", "x", "o" }, "[j", function()
				move.goto_previous_start({ '@conditional.outer' })
			end)

			mapset({ "n", "x", "o" }, "]l", function()
				move.goto_next_start({ '@loop.outer' })
			end)
			mapset({ "n", "x", "o" }, "[l", function()
				move.goto_previous_start({ '@loop.outer' })
			end)

			mapset({ "n", "x", "o" }, "]A", function()
				move.goto_next_end({ '@parameter.outer' })
			end)
			mapset({ "n", "x", "o" }, "[A", function()
				move.goto_previous_end({ '@parameter.outer' })
			end)
			mapset({ "n", "x", "o" }, "]F", function()
				move.goto_next_end({ '@function.outer' })
			end)
			mapset({ "n", "x", "o" }, "[F", function()
				move.goto_previous_end({ '@function.outer' })
			end)
			mapset({ "n", "x", "o" }, "]R", function()
				move.goto_next_end({ '@function.outer' })
			end)
			mapset({ "n", "x", "o" }, "[R", function()
				move.goto_previous_end({ '@function.outer' })
			end)
			mapset({ "n", "x", "o" }, "]C", function()
				move.goto_next_end({ '@class.outer' })
			end)
			mapset({ "n", "x", "o" }, "[C", function()
				move.goto_previous_end({ '@class.outer' })
			end)
			mapset({ "n", "x", "o" }, "]J", function()
				move.goto_next_end({ '@conditional.outer' })
			end)
			mapset({ "n", "x", "o" }, "[J", function()
				move.goto_previous_end({ '@conditional.outer' })
			end)
			mapset({ "n", "x", "o" }, "]L", function()
				move.goto_next_end({ '@loop.outer' })
			end)
			mapset({ "n", "x", "o" }, "[L", function()
				move.goto_previous_end({ '@loop.outer' })
			end)

			-- Select function outer/inner in visual mode
			local select = require('nvim-treesitter-textobjects.select')
			mapset({ "x", "o" }, "af", function()
				select.select_textobject('@function.outer')
			end)
			mapset({ "x", "o" }, "if", function()
				select.select_textobject('@function.inner')
			end)
			mapset({ "x", "o" }, "ac", function()
				select.select_textobject('@class.outer')
			end)
			mapset({ "x", "o" }, "ic", function()
				select.select_textobject('@class.inner')
			end)
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = 'VeryLazy',
		opt = {
			enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 2,   -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 10, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 10, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		}
	},
}
