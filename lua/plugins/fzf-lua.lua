return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"trouble.nvim",
		},
		lazy = false,
		keys = {
			{ "<leader>ff", ":FzfLua files<CR>", desc = "find files" },
			{ "<leader>fg", ":FzfLua live_grep<CR>", desc = "grep file" },
			{ "<leader>fl", ":FzfLua resume<CR>", desc = "last find" },
			{ "<leader>fo", ":FzfLua oldfiles<CR>", desc = "oldfiles" },
			{ "<leader>fb", ":FzfLua buffers<CR>", desc = "buffers" },
			{ "<leader>fh", ":FzfLua help_tags<CR>", desc = "help_tags" },
			{ "<leader>/", ":FzfLua lgrep_curbuf<CR>", desc = "grep current buffer" },
			{ "<leader>fw", ":FzfLua grep_cword<CR>", desc = "grep_cword" },
			{ "<leader>fW", ":FzfLua grep_cWORD<CR>", desc = "grep_cWORD" },
			{ "<leader>gb", ":FzfLua git_branches<CR>", desc = "git branch" },
			{ "<leader>f?", ":FzfLua builtin<CR>", desc = "fzf builtin" },
			{ "<leader>fc", ":FzfLua command_history<CR>", desc = "command_history" },
			{
				"<leader>fz",
				function()
					local function path_of(selected)
						return selected[1]:match("[^\t]+$")
					end
					require("fzf-lua").zoxide({
						actions = {
							["default"] = function(selected)
								local dir = path_of(selected)
								vim.cmd.tcd(dir)
								require("oil").open(dir)
							end,
							["ctrl-t"] = function(selected)
								local dir = path_of(selected)
								vim.cmd.tabnew()
								vim.cmd.tcd(dir)
								require("oil").open(dir)
							end,
						},
					})
				end,
				desc = "recent projects",
			},
			{ "<leader>fm", ":FzfLua marks<CR>", desc = "marks" },
			{ "<leader>fj", ":FzfLua jumps<CR>", desc = "jumps" },
			{ "<leader>fi", ":FzfLua lsp_implementations<CR>", desc = "lsp_implementations" },
			{ "<leader>fr", ":FzfLua lsp_references<CR>", desc = "lsp_references" },
			{ "<leader>ft", ":FzfLua colorschemes<CR>", desc = "switch colorscheme" },
		},
		config = function()
			local fzf_lua = require("fzf-lua")
			fzf_lua.setup({
				grep = {
					rg_glob = true,
				},
			})
			local config = require("fzf-lua.config")
			local actions = require("trouble.sources.fzf").actions
			config.defaults.actions.files["alt-t"] = actions.open

			fzf_lua.register_ui_select()

			vim.api.nvim_create_user_command("Fd", function(opts)
				local directory = opts.args
				directory = directory ~= "" and directory or vim.fn.getcwd()
				fzf_lua.files({ cwd = directory })
			end, { nargs = "?", complete = "dir" })
		end,
	},
}
