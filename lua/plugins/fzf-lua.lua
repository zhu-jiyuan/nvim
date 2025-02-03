return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{ "junegunn/fzf", build = "./install --bin" },
			"trouble.nvim",
		},
		cmd = "FzfLua",
		keys = {
			{ "<leader>ff",  ":FzfLua files<CR>",          desc = "find files" },
			{ "<leader>fg",  ":FzfLua live_grep_glob<CR>", desc = "grep file" },
			{ "<leader>fr",  ":FzfLua resume<CR>",         desc = "resume" },
			{ "<leader>fo",  ":FzfLua oldfiles<CR>",       desc = "oldfiles" },
			{ "<leader>fb",  ":FzfLua buffers<CR>",        desc = "buffers" },
			{ "<leader>fh",  ":FzfLua help_tags<CR>",      desc = "help_tags" },
			{ "<leader>/",   ":FzfLua lgrep_curbuf<CR>",   desc = "help_tags" },
			{ "<leader>fw",  ":FzfLua grep_cword<CR>",     desc = "grep_cword" },
			{ "<leader>fW",  ":FzfLua grep_cWORD<CR>",     desc = "grep_cWORD" },
			{ "<leader>gst", ":FzfLua git_status<CR>",     desc = "git_status" },
			{ "<leader>gb",  ":FzfLua git_branches<CR>",   desc = "git branch" },
			{ "<leader>f?",  ":FzfLua builtin<CR>",        desc = "fzf builtin" },

		},
		config = function()
			-- calling `setup` is optional for customization
			local fzf_lua = require("fzf-lua")
			fzf_lua.setup({
				-- winopts = {
				--     preview = { default = 'bat_native' }
				-- },
				-- fzf_colors = true,
				previewers = {
					bat = {
						cmd = "bat",
						args = "--style=numbers,changes --color=always",
						-- theme = "ansi",
						-- theme = "Coldark-Dark",
					}
				},
				-- fzf = {
				--     cursorline = {
				--         ["fg+"] = "#d41e1e",
				--         ["bg+"] = "#d41e1e"
				--     }
				-- }

			})
			local config = require("fzf-lua.config")
			local actions = require("trouble.sources.fzf").actions
			config.defaults.actions.files["alt-t"] = actions.open

			vim.api.nvim_create_user_command('Fd', function(opts)
				local directory = opts.args
				vim.notify(directory)
				directory = directory ~= "" and directory or vim.fn.getcwd()
				fzf_lua.files({ cwd = directory })
			end, { nargs = '?', complete = 'dir' })
		end,
	},
}
