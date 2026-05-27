return {
	{
		'stevearc/oil.nvim',
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = false,
			experimental_watch_for_changes = true,
			use_default_keymaps = false,
			win_options = {
				concealcursor = "n",
			},
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-s>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				['<BS>'] = 'actions.parent',
				["<C-l>"] = false,
				["<C-j>"] = false,
				["<C-k>"] = false,
				["<C-h>"] = false,
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
				["gd"] = {
					desc = 'Toggle [D]etail view',
					callback = function()
						local oil = require('oil')
						local config = require('oil.config')
						if #config.columns == 1 then
							oil.set_columns({ 'permissions', 'size', 'mtime', 'icon' })
						else
							oil.set_columns({ 'icon' })
						end
					end,
				},

			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name)
					return name == '..'
				end,
			},

		},
		config = function(_, opts)
			require("oil").setup(opts)
			vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end
	}
}
