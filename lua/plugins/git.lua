return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose" },
		opts = function()
			return {
				view = {
					merge_tool = {
						layout = "diff3_mixed",
						disable_diagnostics = true,
						diff_binaries = false,
					},
				},
				keymaps = {
					view = { q = "<cmd>DiffviewClose<CR>" },
					file_panel = { q = "<cmd>DiffviewClose<CR>" },
					file_history_panel = { q = "<cmd>DiffviewClose<CR>" },
				},
				hooks = {
					diff_buf_read = function()
						vim.opt_local.wrap = false
						vim.opt_local.list = false
						vim.opt_local.colorcolumn = { 80 }
					end,
				},
			}
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"NicholasZolton/neojj",
		cmd = "Neojj",
		keys = {
			{ "<leader>gj", ":Neojj<CR>", desc = "Open Neojj" },
		},
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		keys = {
			{ "<leader>go", ":Neogit cwd=%:p:h<CR>", desc = "Uses the repository of the current file" },
			{ "<leader>gc", ":Neogit commit<CR>", desc = "Uses the repository of the current file" },
			{ "<leader>gs", ":Neogit cwd=%:p:h kind=floating<CR>", desc = "Uses the repository of the current file" },
			{ "<leader>gg", ":Neogit<CR>", desc = "Uses the repository of the current file" },
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				auto_show_console = false,
				console_timeout = 10000,
				status = {
					HEAD_padding = 8,
					mode_padding = 2,
					mode_text = {
						M = "● modified",
						N = "+ new file",
						A = "+ added",
						D = "- deleted",
						C = "· copied",
						U = "! updated",
						R = "→ renamed",
						T = "● changed",
						DD = "! unmerged",
						AU = "! unmerged",
						UD = "! unmerged",
						UA = "! unmerged",
						DU = "! unmerged",
						AA = "! unmerged",
						UU = "! unmerged",
						["?"] = "",
					},
				},
			})
		end,
	},
}
