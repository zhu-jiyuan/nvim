return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
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
				"toml",
				"tsx",
				"typescript",
				"typst",
				"vim",
				"vimdoc",
				"yaml",
				"zsh",
			}, { max_jobs = 4 })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
		event = "VeryLazy",
		branch = "main",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = true,
				},
				move = {
					set_jumps = true,
				},
			})
			local mapset = vim.keymap.set
			local move = require("nvim-treesitter-textobjects.move")
			local modes = { "n", "x", "o" }

			-- ]x / [x jump to the next / previous start, ]X / [X to the next / previous end.
			local targets = {
				a = "@parameter.outer",
				f = "@function.outer",
				c = "@class.outer",
				j = "@conditional.outer",
				l = "@loop.outer",
			}
			for key, query in pairs(targets) do
				mapset(modes, "]" .. key, function()
					move.goto_next_start(query)
				end)
				mapset(modes, "[" .. key, function()
					move.goto_previous_start(query)
				end)
				mapset(modes, "]" .. key:upper(), function()
					move.goto_next_end(query)
				end)
				mapset(modes, "[" .. key:upper(), function()
					move.goto_previous_end(query)
				end)
			end

			-- In diff mode ]c / [c keep their built-in meaning: jump to the next / previous change.
			for key, jump in pairs({ ["]c"] = move.goto_next_start, ["[c"] = move.goto_previous_start }) do
				mapset(modes, key, function()
					if vim.wo.diff then
						vim.cmd.normal({ vim.v.count1 .. key, bang = true })
					else
						jump(targets.c)
					end
				end)
			end

			local select = require("nvim-treesitter-textobjects.select")
			mapset({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer")
			end)
			mapset({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner")
			end)
			mapset({ "x", "o" }, "ac", function()
				select.select_textobject("@class.outer")
			end)
			mapset({ "x", "o" }, "ic", function()
				select.select_textobject("@class.inner")
			end)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		opts = {
			max_lines = 2,
			multiline_threshold = 10,
			mode = "topline",
			zindex = 10,
		},
	},
}
