return {
	{
		dir = "~/dev/go-impl.nvim",
		ft = "go",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
		},
		opts = {},
		keys = {
			{
				"<leader>gi",
				function()
					require("go-impl").open()
				end,
				mode = { "n" },
				desc = "Go Impl",
			},
		},
	}
}
