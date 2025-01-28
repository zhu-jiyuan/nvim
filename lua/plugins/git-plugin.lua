return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				-- current_line_blame = true,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = {"DiffviewOpen", "Neogit"},
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"ibhagwan/fzf-lua", -- optional
		},
		keys = {
			{ "<leader>go", ":Neogit cwd=%:p:h<CR>",               desc = "Uses the repository of the current file" },
			{ "<leader>gc", ":Neogit commit<CR>",                  desc = "Uses the repository of the current file" },
			{ "<leader>gs", ":Neogit cwd=%:p:h kind=floating<CR>", desc = "Uses the repository of the current file" },
			{ "<leader>gg", ":Neogit<CR>",                         desc = "Uses the repository of the current file" },
		},
		config = function()
			local neogit = require "neogit"
			neogit.setup({
				auto_show_console = false,
				disable_commit_confirmation = true,
				console_timeout = 10000,
			})
		end,
	}
}
