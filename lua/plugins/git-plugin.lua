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
		cmd = "DiffviewOpen",
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
		},
		config = true,
	}
}
