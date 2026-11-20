return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-python",
		},
		cmd = "Neotest",
		keys = {
			{
				"<leader>tl",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},

			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run tests in current file",
			},

			{
				"<leader>tr",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test results summary",
			},

			{
				"<leader>ts",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop test",
			},

			{
				"<leader>ta",
				function()
					require("neotest").run.attach()
				end,
				desc = "Attach to test",
			},

			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true })
				end,
				desc = "Open test output",
			},

			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle test output panel",
			},
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-python")({
						runner = "pytest",
						args = { "--log-level", "DEBUG", "-vv", "-s" },
					}),
					require("neotest-plenary"),
				},
				status = {
					enabled = true,
					signs = true,
					virtual_text = true,
				},
				output = {
					open_on_run = true,
				},
			})
		end,
	},
}
